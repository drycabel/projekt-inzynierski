class Event < ApplicationRecord
    has_many :memberships
    belongs_to :owner, class_name: "User", foreign_key: :owner_id

    #walidacja na poziomie bazy danych
    # validates :title, presence: true
    def can_i_join?(user)
        user != owner && !memberships.find_by(user: user).present?
    end
end