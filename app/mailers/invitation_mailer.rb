class InvitationMailer < ApplicationMailer

    def call(invitation)
        @invitation = invitation.reload
        @accept_url = if @invitation.recipient_id.present?
                        new_session_url(token: @invitation.token.value, email: @invitation.email)
                      else
                        new_registration_url(token: @invitation.token.value, email: @invitation.email)
                      end
        @refuse_url = "#"
        mail(to: @invitation.email, subject: 'Event invitation')
    end
end