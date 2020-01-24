class ResetPasswordsController < ApplicationController
    skip_before_action :authenticate_user

    def new
        @form = CreateResetPasswordForm.new
    end

    def create

    end

    def edit

    end

    def update

    end

    private

    def reset_password_params
        params.require(:session).permit(:email, :password, :password_re_type, :token)
    end
end