class ApplicationController < ActionController::Base
    before_action :authenticate_user

    def current_user
        return @current_user if defined?(@current_user)
        @current_user = User.find_by(id: session[:user_id])
       
    end

    helper_method :current_user
    
    def authenticate_user
        return if current_user.present?
        redirect_to new_session_path, alert: 'Access denied'
    end
end
