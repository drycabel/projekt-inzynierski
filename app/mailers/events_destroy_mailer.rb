class EventsDestroyMailer < ApplicationMailer
    def call(email, event)
        @event = event
        mail(to: email, subject: 'Event has been destroyed')
    end
end