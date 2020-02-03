class EventsController < ApplicationController

    def index
        params[:category].present? ? @events = current_user.events : @events = Event.all
        @event_roles = Membership.where(event_id: @events.ids, user_id: current_user.id).each_with_object({}) {|member, result| result[member.event_id] = member.role}
        #  binding.pry
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
        if Event.exists?(params[:id])
            @form = EventUpdaterForm.new(event_id: params[:id])
        else
            redirect_to events_path, alert: "Event with id: #{params[:id]} doesn't exist"
        end
    end

    def update
        @form = EventUpdaterForm.new(event_params.merge(owner: current_user, event_id: params[:id]))
        if @form.save
            redirect_to events_path, notice: "Event updated successfully"
        else
            render :edit
        end
    end

    def show
        if @event = Event.find_by_id(params[:id])
            @event_roles = Membership.where(event_id: @event.id, user_id: current_user.id).each_with_object({}) {|member, result| result[member.event_id] = member.role}
        else
            redirect_to events_path, alert: "Event with id: #{params[:id]} doesn't exist"
        end
    end

    def destroy
        service = EventDestroyer.new(params[:id], current_user)
        key = (service.destroyed_successfully? ? "notice" : "alert")
        redirect_to events_path, {"#{key}": service.msg}
    end

    private

    def event_params
        params.permit(:title, :description, :event_date, :event_time, :street, :city, :province, :zip)
    end
end