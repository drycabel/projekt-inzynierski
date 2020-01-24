class CreateResetPasswordForm
    include ActiveModel::Model

    attr_accessor :email, :token

    validate :email

    def send
        return false unless valid?

        true
    rescue => e
        errors.add(:base, "Something went wrong #{e.inspect}")
        false
    end

end