class InvitationRefuseService

    def initialize(token_value, user = nil)
        @user = user
        @token_value = token_value
        @success = false
    end

    def call
        return false unless token.present?
        invitation.refused!
        inactivate_tokens
        @success = true
    rescue
        false
    end

    def redirect_path
        return nil if !@success || !token || !event
        Rails.application.routes.url_helpers.event_path(event)
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

    def inactivate_tokens
        invitation.tokens.update_all(active: false)
    end

    def invitation
        @invitation ||= token&.ownerable
    end
end