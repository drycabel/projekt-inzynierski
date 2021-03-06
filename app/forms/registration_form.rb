class RegistrationForm
    include ActiveModel::Model

    attr_accessor :email, :password, :password_confirmation, :token, :name, :surname, :birth_date, :short_bio

    validates :email, :password, :password_confirmation, presence: true
    validates :password, confirmation: { case_sensitive: true }

    #validacja na haslo min 8 znakow
    # validates :email_uniq

    def save
        return false unless valid?
        ActiveRecord::Base.transaction do
            call
        end
        true
    rescue => e
        errors.add(:base, "Something went wrong #{e.inspect}")
        false
    end


    def invitation_service
        @invitation_service ||= InvitationConfirmationService.new(token || "", user)
    end

    def invited_user?
        @invited_user || false
    end

    def user
        existed_user || @user
    end

    private

    def call
        UserExistMailer.call(email).deliver! and return if existed_user.present? && existed_user.confirmed?
        inactivate_tokens if existed_user.present? && existed_user.unconfirmed?
        create_user unless user.present?
        @user = user.unconfirm if user.new?
        @invited_user = invitation_service.call
        # binding.pry
        if invited_user?
            user.confirm
        else
            SignupMailer.call(email, token_object.value, token.present?).deliver!
        end
    end

    def existed_user
        return @existed_user if defined? @existed_user
        @existed_user = User.find_by("lower(email) = ?", email.downcase)
    end

    def inactivate_tokens
        existed_user.tokens.update_all(active: false)
    end

    def create_user
        @user = User::New.create!(email: email, password: password, name: name, surname: surname, birth_date: birth_date, short_bio: short_bio)
    end

    def token_object
        @token_object ||= user.tokens.create
    end

end