class RegistrationsController < ApplicationController
    skip_before_action :authenticate_user, only: [:new, :create]
    def new

    end

    def create
       # binding.pry
       user = User.new(email: params[:email], password: params[:password])
       if user.save
            token = Token.create(email: params[:email], value: SecureRandom.uuid)
             SignupMailer.call(params[:email], token.value).deliver!
            redirect_to root_path, notice: "User was succesfully registered"
       else
       end
    end

end