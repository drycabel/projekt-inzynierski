class EventJoiner
    attr_reader :msg

    def initialize(current_user, event_id)
        @current_user = current_user
        @event_id = event_id
        @msg = "Joined successfully"
    end

    def joined_successfully?
        return false unless validations_succeed?

        event.memberships.create!(user: @current_user)
        true
    rescue => e
        @msg = "Something went wrong - #{e.inspect}"
        false
    end

    def event
        return @event if defined? @event
        @event = Event.find_by(id: @event_id)
    end

    private

    def validations_succeed?
        @msg = "You have to be logged in" and return false if @current_user.blank?

        @msg = "Event doesn't exist" and return false if event.blank?

        @msg = "You have been already added to this event" and return false if !event&.can_i_join?(@current_user)

        true
    end

end