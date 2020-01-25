class CreateResetPasswordForm
    include ActiveModel::Model

    attr_accessor :email

    validates :email, presence: true

    def sent
        return false unless valid?
        call
        true
    rescue => e
        errors.add(:base, "Something went wrong #{e.inspect}")
        false
    end

    private

    def call
        ResetPasswordsMailer.call(email, token_object.value).deliver! and return if user.present? && user.confirmed?
        inactivate_tokens if user.present? && user.unconfirmed?
        if user.unconfirmed?
            SignupMailer.call(email, token_object.value).deliver!
        else
            return
        end
    end

    def user
        @user ||= User.find_by("lower(email) = ?", email.downcase)
    end

    def token_object
        @token_object ||= user.tokens.create
    end

    def inactivate_tokens
        user.tokens.update_all(active: false)
    end

end