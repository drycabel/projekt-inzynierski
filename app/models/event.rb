class Event < ApplicationRecord
    has_many :memberships
    belongs_to :owner, class_name: "User", foreign_key: :owner_id

    validates :title, presence: true
end