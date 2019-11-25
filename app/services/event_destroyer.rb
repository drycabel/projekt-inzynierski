class EventDestroyer
    attr_reader :msg

    def initialize(event_id, current_user)
        @current_user = current_user
        @event_id = event_id
    end

    def event
        return @event if defined? @event
        @event = Event.find_by(id: @event_id)
    end

    def destroyed_successfully?
        return false unless validations_succeed?

        event.destroy!
        send_emails

        @msg = "Event destroyed successfully"
        true
    rescue => e
        @msg = "Something went wrong - #{e.inspect}"
        false
    end

    def send_emails
        event.members.each do |m|
            next if m.user_id == @current_user.id
            EventsDestroyMailer.call(m.email, event).deliver!
        end
    end

    private

    def validations_succeed?
        @msg = "You have to be logged in" and return false if @current_user.blank?

        @msg = "Event doesn't exist" and return false if event.blank?

        @msg = "You are not owner" and return false if event.owner_id != @current_user.id

        true
    end

end