class InvitationForm
    include ActiveModel::Model

    attr_accessor :email, :current_user, :event

    validates :email, :current_user, :event, presence: true
    validate :member_uniqueness
    validate :invitation_uniqueness

    def save
        return false unless valid?
        ActiveRecord::Base.transaction { call }
        true
    rescue => e
        # binding.pry
    end

    def call
        InvitationMailer.call(invitation).deliver!
    end


    private

    def invitation
        @invitation ||= Invitation.create!(invitation_params)
    end

    def member_uniqueness
        return unless event.users.map {|user| user.email.downcase}.include?(email)
        errors.add(:base, "Member already exists")
    end

    def invitation_uniqueness
        return unless event.invitations.map {|invitation| invitation.email.downcase}.include?(email)
        errors.add(:base, "Invitation already sent")
    end

    def invitation_params
        {
            sender_id: current_user.id,
            event_id: event.id,
            recipient_id: find_recipient_id,
            email: email,
        }
    end

    def find_recipient_id
        # binding.pry
        User.find_by("lower(email) = ?", email.downcase)&.id
        # User.includes(:memberships).where("lower(email) = ? AND memberships.event_id = ?", email.downcase, event.id).references(:memberships).first&.id
    end

end