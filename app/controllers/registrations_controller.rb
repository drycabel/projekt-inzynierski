class RegistrationsController < ApplicationController
    skip_before_action :authenticate_user, only: [:new, :create]
    def new
        @form = RegistrationForm.new
    end

    def create
       # binding.pry
       @form = RegistrationForm.new(registration_params)
       if @form.save
        session[:user_id] = @form.user.id if @form.invited_user?
        redirect_to @form.invitation_service.redirect_path || root_path, notice: @form.invited_user? ? "Account created and invitation to #{@form.invitation_service.event.title} accepted" : "Confirmation email was sent"
       else
        render :new
       end
    end

    private

    def registration_params
        params.require(:session).permit(:email, :password, :password_confirmation, :token, :name, :surname, :birth_date, :short_bio, :address)
    end

end