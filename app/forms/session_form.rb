# frozen_string_literal: true

class SessionForm
    include ActiveModel::Model

    attr_accessor :email, :password

    validate :credentials_presence

    def user
        @user ||= User.find_by_email(email)&.authenticate(password)
    end


    private

    def credentials_presence
        return if email.present? && password.present? && user.present?
        errors.add(:base, 'invalid credentials')
    end



end