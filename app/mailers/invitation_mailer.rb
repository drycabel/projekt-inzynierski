class InvitationMailer < ApplicationMailer

    def call(invitation)
        @invitation = invitation.reload
        @accept_url = if @invitation.recipient_id.present?
                        new_session_url(token_value: @invitation.token.value, email: @invitation.email, invitation_refused: false)
                      else
                        new_registration_url(token_value: @invitation.token.value, email: @invitation.email)
                      end
        @refuse_url = if @invitation.recipient_id.present?
                        new_session_url(token_value: @invitation.token.value, email: @invitation.email, invitation_refused: true)
                      else
                        invitations_refuse_url(token_value: @invitation.token.value, email: @invitation.email)
                      end
        mail(to: @invitation.email, subject: 'Event invitation')
    end
end