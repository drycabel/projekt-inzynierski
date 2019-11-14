class EventsController < ApplicationController

    def index
        @events = Event.all
    end

    def new
        @form = EventCreatorForm.new
    end

    def create
        @form = EventCreatorForm.new(event_params.merge(current_user: current_user))
        if @form.save
            redirect_to events_path, notice: "Event created successfully"
        else
            render :new
        end
    end

    def edit
        @event = Event.find(params[:id])
    end

    def update
        @event = Event.find(params[:id])
        if @event.update_attributes!(event_params)
            redirect_to events_path, notice: "Event updated successfully"
        else
            render :edit
        end
    end

    def show
        @event = Event.find(params[:id])
    end

    def confirm_destroy
        @event = Event.find(params[:id])
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to events_path, notice: "Event destroyed successfully"
    end

    private

    def event_params
        params.permit(:title, :description)
    end
end