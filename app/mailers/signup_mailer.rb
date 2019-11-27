class SignupMailer < ApplicationMailer
    def call(email, token)
        @token = token
        @email = email
        mail(to: email, subject: 'Registration')
    end
end