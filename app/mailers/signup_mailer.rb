class SignupMailer < ApplicationMailer
    def call(email, token) 
        @token = token
        mail(to: email, subject: 'import failed')
    end
    # def call(recipient,token)
    #     @token = token
    #     from = Email.new(email: 'rycabel.dawid@gmail.com')
    #     to = Email.new(email: recipient)
    #     subject = 'Sending with SendGrid is Fun'
    #     content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
    #     mail = Mail.new(from, subject, to, content)

    #     sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    #     response = sg.client.mail._('send').post(request_body: mail.to_json)
    #     puts response.status_code
    #     puts response.body
    #     puts response.headers
    # end
end