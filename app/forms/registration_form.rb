class RegistrationForm
    include ActiveModel::Model

    attr_accessor :email, :password

    validates :email, presence: true
    # validates :email_uniq

    def save
        return false unless valid?
        call
        send_email
        true
    rescue => e
        @user&.destroy
        @token&.destroy
    end

    private

    def call
        ActiveRecord::Base.transaction do
            begin 
                create_user
                token
            rescue => e
                fail "User can't be created"
            end
        end
    end

    def send_email
        SignupMailer.call(email, token.value).deliver!
    end

    def create_user
        @user = User.create!(email: email, password: password)
    end

    def token
        @token ||= Token.create(email: email, value: SecureRandom.uuid)
    end

    def email_uniq
        return unless User.find_by(email: email).present?
        errors.add(:email, "already taken")
    end

end