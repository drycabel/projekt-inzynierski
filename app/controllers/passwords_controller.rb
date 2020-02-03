class PasswordsController < ApplicationController
    def edit
        if User.exists?(params[:user_id])
            @form = UpdatePasswordForm.new(user_id: params[:user_id])
        else
            redirect_to root_path, alert: "User with id #{params[:user_id]} doesn't exist"
        end
    end

    def update
        @form = UpdatePasswordForm.new(password_params.merge(current_user: current_user, user_id: params[:user_id]))
        if @form.save
            redirect_to user_path(params[:user_id]), notice: "Password updated successfully"
        else
            render :edit
        end
    end

    private

    def password_params
        params.require(:session).permit(:old_password, :password, :password_re_type)
    end

end