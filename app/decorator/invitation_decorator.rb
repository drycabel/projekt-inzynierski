class InvitationDecorator

    STATUS_MAPPER = {
        'sent' => 'dark',
        'refused' => 'danger',
    }

    def initialize(invitation)
        @invitation = invitation
    end

    def boostrap_color_class
        STATUS_MAPPER[@invitation.status]
    end

    delegate :email, to: :@invitation
end