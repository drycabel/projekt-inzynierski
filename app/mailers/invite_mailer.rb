class InviteMailer < ApplicationMailer

    def call(email, event, token)
        @event = event
        @token = token
        mail(to: email, subject: 'Event invitation')
    end
end