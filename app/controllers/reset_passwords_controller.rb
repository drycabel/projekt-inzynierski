class ResetPasswordsController < ApplicationController
    skip_before_action :authenticate_user

    def new
        @form = CreateResetPasswordForm.new
    end

    def create
        @form = CreateResetPasswordForm.new(reset_password_params)
        if @form.sent
            redirect_to root_path, notice: "Message with instructions was sent to your email address."
        else
            render :new
        end
    end

    def edit
        @form = UpdateResetPasswordForm.new(email: params[:email], token_value: params[:token_value])
    end

    def update
        @form = UpdateResetPasswordForm.new(reset_password_params)
        if @form.save
            redirect_to new_session_path(email: params[:email]), notice: "Password reset successfully."
        else
            render :edit
        end
    end

    private

    def reset_password_params
        params.require(:session).permit(:email, :password, :password_confirmation, :token_value)
    end
end