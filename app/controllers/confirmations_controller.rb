class ConfirmationsController < ApplicationController
    skip_before_action :authenticate_user, only: [:show]

    def show
        form = ConfirmationAccountForm.new(token_params)
        if form.save
            redirect_to new_session_path(email: params[:email]), notice: "Account confirmed, now you can sign in"
        else
            redirect_to root_path, alert: form.errors.full_messages.join("\n")
        end
    end

    private

    def token_params
        params.permit(:token, :email)
    end
end