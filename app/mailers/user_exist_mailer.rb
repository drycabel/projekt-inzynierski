class UserExistMailer < ApplicationMailer
    def call(email)
        mail(to: email, subject: 'Registration atempt')
    end
end