class EventDecorator

    def initialize(event)
        @event = event
    end

    def owner_email
        @event.owner&.email || "-"
    end

    def role_for(user)
        @role ||= @event.role_for(user)
    end

    def short_desc
        @event&.description&.truncate(27) || "-"
    end

    delegate :title, :description, :event_date, :event_time, to: :@event
end