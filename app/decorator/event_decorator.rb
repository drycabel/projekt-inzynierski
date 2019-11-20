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

    delegate :title, :description, to: :@event
end