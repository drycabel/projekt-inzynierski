class InvitationsController < ApplicationController
    def create
       # binding.pry
       @form = InvitationForm.new(invitation_params)
       if @form.save
        redirect_to event_path(event), notice: "Invitation has been created successfully"
       else
        redirect_to event_path(event), alert: @form.errors.full_messages.join("\n")
       end
    end

    private

    def invitation_params
        params.permit(:email).merge(current_user: current_user, event: event)
    end

    def event
        @event ||= Event.find(params[:event_id])
    end

end