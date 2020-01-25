class UpdateResetPasswordForm
    include ActiveModel::Model

    attr_accessor :email, :password, :password_confirmation, :token_value

    validates :password, :password_confirmation, presence: true
    validates :password, confirmation: { case_sensitive: true }

    def save
        return false unless valid? && token_object.present?
        call
        true
    rescue => e
        errors.add(:base, "Something went wrong #{e.inspect}")
        false
    end


    private

    def call
        user.update!(password: password)
        inactivate_tokens
    end

    def token_object
        return @token_object if defined? @token_object
        @token_object = begin
           t = Token.find_by(ownerable_type: "User", value: token_value)
           (t.present? && !t.used? && !t.expired?) ? t : nil
        end
    end

    def user
        @user ||= User.find_by("lower(email) = ?", email.downcase)
    end

    def inactivate_tokens
        user.tokens.update_all(active: false)
    end

end