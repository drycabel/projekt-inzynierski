class RegistrationsController < ApplicationController
    skip_before_action :authenticate_user, only: [:new, :create]
    def new
        @form = RegistrationForm.new
    end

    def create
       # binding.pry
       @form = RegistrationForm.new(registration_params)
       if @form.save
        redirect_to root_path, notice: "Confirmation email was sent"
       else
        render :new
       end
    end

    private

    def registration_params
        params.permit(:email, :password)
    end

end