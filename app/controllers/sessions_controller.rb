class SessionsController < ApplicationController
    skip_before_action :authenticate_user, only: [:new, :create]
    def new 
    end

    def create
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, notice: "Logged in"
        else
            flash.now[:alert] = "Email or password is invalid"
            render "new"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out!"
    end

    
end
# # controller 
# def new
#     @form = AdminSessionForm.new
#   end

#   def create
#     @form = AdminSessionForm.new(admin_params)
#     if @form.valid?
#       session[:admin_id] = @form.admin.id
#       redirect_to admin_dashboards_path,
#                   notice: I18n.t('notices.success_sign_in')
#     else
#       render :new
#     end
#   end
#   def admin_params
#     params.require(:admin).permit(:email, :password)
#   end

# #   form
# frozen_string_literal: true
# class AdminSessionForm
#   include ActiveModel::Model

#   # :reek:Attribute
#   attr_accessor :email, :password

#   validate :credentials_presence

#   def admin
#     @admin ||= Administrator.find_by_email(email)&.authenticate(password)
#   end

#   private

#   def credentials_presence
#     return if email.present? && password.present? && admin.present?
#     errors.add(:base, I18n.t('form.invalid_credentials'))
#     false
#   end
# end # class AdminSessionForm