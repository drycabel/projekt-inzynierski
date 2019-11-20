class JoinEventsController < ApplicationController
    def create
        service = EventManager.new(current_user, params[:event_id])
        if service.joined_successfully?
            redirect_to event_path(service.event), notice: service.msg
        else
            redirect_to events_path, alert: service.msg
        end
    end
end