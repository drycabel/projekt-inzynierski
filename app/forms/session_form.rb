# frozen_string_literal: true

class SessionForm
    include ActiveModel::Model

    attr_accessor :email, :password, :token

    validate :credentials_presence



    def save
        return false unless valid?
        @invited_user = invitation_service.call
        true
    end

    def user
        @user ||= User.find_by(email: email)&.authenticate(password)
    end

    def invitation_service
        @invitation_service ||= InvitationConfirmationService.new(token || "")
    end

    def invited_user?
        @invited_user || false
    end

    private



    def credentials_presence
        return if email.present? && password.present? && user.present? && user.confirmed?
        errors.add(:base, 'invalid credentials')
    end
end