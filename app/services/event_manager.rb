class EventManager
    attr_reader :msg

    def initialize(current_user, event_id)
        @current_user = current_user
        @event_id = event_id
    end

    def joined_successfully?
        return false unless validations_succeed_for_join?

        event.memberships.create!(user: @current_user)
        @msg = "Joined successfully"
        true
    rescue => e
        @msg = "Something went wrong - #{e.inspect}"
        false
    end

    def quited_successfully?
        # binding.pry
        return false unless validations_succeed_for_quit?

        event.memberships.find_by!(user: @current_user).destroy
        @msg = "Quited successfully"
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

    def validations_succeed_for_join?
        @msg = "You have to be logged in" and return false if @current_user.blank?

        @msg = "Event doesn't exist" and return false if event.blank?

        @msg = "You have been already added to this event" and return false if event.memberships.find_by(user_id: @current_user.id).present?

        true
    end

    def validations_succeed_for_quit?
        @msg = "You have to be logged in" and return false if @current_user.blank?

        @msg = "Event doesn't exist" and return false if event.blank?

        @msg = "You are creator" and return false if event.owner_id == @current_user.id

        true
    end

end