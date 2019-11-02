class EventDecorator 

    def initialize(event)
        @event = event
    end

    def owner_email
        @event.owner&.email || "-"
    end

    delegate :title, :description, to: :@event
end