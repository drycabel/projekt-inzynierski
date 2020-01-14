class User < ApplicationRecord
    include Morphable

    BOOLAEN_METHODS = %w[new confirmed unconfirmed].freeze

    has_one :address, as: :addressable
    has_many :tokens, as: :ownerable
    has_many :memberships
    has_many :events, through: :memberships
    has_many :own_events, foreign_key: :owner_id, class_name: "Event"
    has_many :invitations, foreign_key: :recipient_id, class_name: "Invitation"
    has_many :sent_invitations, foreign_key: :sender_id, class_name: "Invitation"

    has_secure_password validations: false

    BOOLAEN_METHODS.each do |method_name|
        define_method "#{method_name}?" do
            false
        end
    end
end