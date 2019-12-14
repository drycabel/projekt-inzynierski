class SessionsController < ApplicationController
    skip_before_action :authenticate_user, only: [:new, :create]

    before_action :redirect_logged_user

    def new
        @form = SessionForm.new
    end

    def create
        @form = SessionForm.new(user_params)
        if @form.save
            session[:user_id] = @form.user.id
            redirect_to @form.invitation_service.redirect_path || root_path,
            notice:
                if @form.invited_user? && @form.invitation_refused?
                    "Invitation refused successfully"
                elsif @form.invited_user? && !@form.invitation_refused?
                    "Invitation accepted successfully"
                else
                    "Logged in"
                end
        else
            render :new
            # render "sessions/new.html.erb"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out!"
    end

    private

    def user_params
        params.require(:session).permit(:email, :password, :token_value, :invitation_refused)
    end

    def redirect_logged_user
        return unless current_user.present?
        if params[:token_value].present? && params[:invitation_refused] == "false"
            service = InvitationConfirmationService.new(params[:token_value])
            if service.call
                redirect_to event_path(service.event), notice: "Invitation accepted successfully" and return
            else
                redirect_to events_path, notice: "You are already logged in"
            end
        elsif params[:token_value].present? && params[:invitation_refused] == "true"
            service = InvitationRefuseService.new(params[:token_value])
            if service.call
                redirect_to event_path(service.event), notice: "Invitation refused successfully" and return
            else
                redirect_to events_path, notice: "You are already logged in"
            end
        end
    end
end
