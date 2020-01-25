# frozen_string_literal: true

class SessionForm
    include ActiveModel::Model

    attr_accessor :email, :password, :token_value, :invitation_refused

    validate :credentials_presence



    def save
        return false unless valid?
        # binding.pry
        @invited_user = invitation_service.call
        # invitation_service.call
        true
    end

    def user
        @user ||= User.find_by("lower(email) = ?", email.downcase)&.authenticate(password)
    end

    def invitation_service
        invitation_refused? ? @invitation_service ||= InvitationRefuseService.new(token_value || "") : @invitation_service ||= InvitationConfirmationService.new(token_value || "")
    end

    def invitation_refused?
        invitation_refused == "true"
    end

    def invited_user?
        @invited_user || false
    end

    private

    def downcase_email
        email.downcase!
    end

    def credentials_presence
        return if email.present? && password.present? && user.present? && user.confirmed?
        errors.add(:base, 'invalid credentials')
    end
end