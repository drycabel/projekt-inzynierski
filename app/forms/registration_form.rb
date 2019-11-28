class RegistrationForm
    include ActiveModel::Model

    attr_accessor :email, :password

    validates :email, :password, presence: true
    #validacja na haslo min 8 znakow
    # validates :email_uniq

    def save
        return false unless valid?
        ActiveRecord::Base.transaction { call }
        true
    rescue => e
        errors.add(:base, "Something went wrong #{e.inspect}")
        false
    end

    private

    def call
        UserExistMailer.call(email).deliver! and return if existed_user.present? && existed_user.confirmed?
        inactivate_tokens if existed_user.present? && existed_user.unconfirmed?
        create_user
        SignupMailer.call(email, token.value).deliver!
        user.unconfirm
    end

    def existed_user
        return @existed_user if defined? @existed_user
        @existed_user = User.find_by("lower(email) = ?", email)
    end

    def inactivate_tokens
        existed_user.tokens.update_all(active: false)
    end

    def user
        @user ||= User::New.create!(email: email, password: password)
    end

    def create_user
        user
    end

    def token
        @token ||= user.tokens.create
    end
end