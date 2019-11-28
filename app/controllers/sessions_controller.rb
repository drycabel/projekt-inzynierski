class SessionsController < ApplicationController
    skip_before_action :authenticate_user, only: [:new, :create]

    before_action :redirect_logged_user

    def new
        @form = SessionForm.new
    end

    def create
        @form = SessionForm.new(user_params)
        if @form.valid?
            # binding.pry
            session[:user_id] = @form.user.id
            redirect_to root_path, notice: "Logged in"
        else
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out!"
    end

    private

    def user_params
        params.permit(:email, :password)
    end

    def redirect_logged_user
        return unless current_user.present?
        if params[:token].present?
            service = InvitationConfirmationService.new(params[:token])
            if service.call
                redirect_to event_path(service.event.id) and return
            else
                redirect_to events_path, notice: "You are already logged in"
            end
        end

    end


end
