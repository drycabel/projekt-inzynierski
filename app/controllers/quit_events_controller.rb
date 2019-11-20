class QuitEventsController < ApplicationController
    def destroy
        service = EventManager.new(current_user, params[:event_id])
        # if service.quited_successfully?
        #     redirect_to events_path, notice: service.msg
        # else
        #     redirect_to events_path, alert: service.msg
        # end
        key = (service.quited_successfully? ? "notice" : "alert")
        redirect_to events_path, {"#{key}": service.msg}
    end
end