class User < ApplicationRecord
    has_many :memberships
    has_many :events, through: :memberships
    has_many :own_events, foreign_key: :owner_id, class_name: "Event"

    has_secure_password validations: false
end