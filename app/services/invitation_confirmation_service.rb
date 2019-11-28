class InvitationConfirmationService

    def initialize(token_value, user = nil)
        @user = user
        @token_value = token_value
    end

    def call
        return false unless token.present?
        event.memberships.create!(user_id: (invitation.recipient_id || user&.id))
        invitation.accepted!
        true
    rescue
        false
    end

    def token
        return @token if defined? @token
        @token = begin
           t = Token.find_by(ownerable_type: "Invitation", value: @token_value)
           (t.present? && !t.used? && !t.expired?) ? t : nil
        end
    end

    def event
        @event ||= invitation&.event
    end

    private

    def invitation
        @invitation ||= token&.ownerable
    end
end