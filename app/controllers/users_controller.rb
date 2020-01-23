class UsersController < ApplicationController

    def show
        if @user = User.find_by_id(params[:id])
            @destroy_message ="Are you sure you want to delete your account?\nPlease note: If you delete your account, you won't be able to reactivate it later"
        else
            redirect_to root_path, alert: "Profile with id: #{params[:id]} doesn't exist"
        end
    end

    def edit
        if User.exists?(params[:id])
            @form = UserUpdaterForm.new(user_id: params[:id])
        else
            redirect_to root_path, alert: "User with id #{params[:id]} doesn't exist"
        end
    end

    def update
        @form = UserUpdaterForm.new(user_params.merge(logged_user: current_user, user_id: params[:id]))
        if @form.save
            redirect_to user_path(params[:id]), notice: "User data updated successfully"
        else
            render :edit
        end
    end

    def destroy
        service = UserDestroyerService.new(params[:id], current_user)
        if service.destroyed_successfully?
            session[:user_id] = nil
            redirect_to root_path, notice: service.msg
        else
            redirect_to user_path(params[:id]), alert: service.msg
        end
    end

    private

    def user_params
        params.require(:session).permit(:email, :name, :surname, :birth_date, :short_bio)
    end

end