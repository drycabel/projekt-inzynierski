class SignupMailer < ApplicationMailer
    def call(email, token, with_invitation_notice = false)
        @token = token
        @email = email
        @with_invitation_notice = with_invitation_notice
        mail(to: email, subject: 'Registration')
    end
end