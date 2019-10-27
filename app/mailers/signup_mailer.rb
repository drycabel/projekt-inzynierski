class SignupMailer < ApplicationMailer
    def call(email, token) 
        @token = token
        mail(to: email, subject: 'import failed')
    end
end