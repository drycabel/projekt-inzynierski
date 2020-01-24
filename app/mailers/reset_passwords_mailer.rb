class ResetPasswordsMailer < ApplicationMailer

    def call(email, token)
        @email = email
        @token = token
        mail(to: email, subject: 'Reset password')
    end

end