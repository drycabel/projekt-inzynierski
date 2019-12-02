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
            redirect_to @form.invitation_service.redirect_path || root_path, notice: "Logged in"
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
        params.require(:session).permit(:email, :password, :token)
    end

    def redirect_logged_user
        return unless current_user.present?
        if params[:token].present?
            service = InvitationConfirmationService.new(params[:token])
            if service.call
                redirect_to event_path(service.event) and return
            else
                redirect_to events_path, notice: "You are already logged in"
            end
        end
    end
end
