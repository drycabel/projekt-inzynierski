class InvitationForm
    include ActiveModel::Model

    attr_accessor :email, :current_user, :event

    validates :email, :current_user, :event, presence: true
    validate :member_uniqueness
    validate :invitation_uniqueness

    def save
        return false unless valid?
        #
        true
    rescue => e
        #
    end

    def call

    end


    private

    def send_email
        # InvitationMailer.call(email, event, token.value).deliver!
    end

    def token
        @token ||= Token.create(email: email.downcase, value: SecureRandom.uuid)
    end

    def member_uniqueness
        return unless event.users.map {|user| user.email.downcase}.include?(email)
        errors.add(:base, "Member already exists")
    end

    def invitation_uniqueness
        return unless event.invitations.map {|invitation| invitation.email.downcase}.include?(email)
        errors.add(:base, "Invitation already sent")
    end

end