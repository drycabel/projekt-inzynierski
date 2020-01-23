class UsersDestroyMailer < ApplicationMailer
    def call(user)
        @user = user
        mail(to: user.email, subject: 'Account has been destroyed')
    end
end