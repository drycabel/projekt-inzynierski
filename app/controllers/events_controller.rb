class EventsController < ApplicationController

    def index 
        @events = Event.all
    end

    def new 
        @event = Event.new
    end

    def create 
        # binding.pry
        @event = Event.new(event_params)
        if @event.save
            redirect_to events_path, notice: "Event created sucessfully"            
        else
            render :new
        end
    end

    private

    def event_params
        params.require(:event).permit(:title, :description)
    end
end