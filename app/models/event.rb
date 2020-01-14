class Event < ApplicationRecord
    has_one :address, as: :addressable
    has_many :invitations
    has_many :memberships, dependent: :destroy
    has_many :users, through: :memberships
    belongs_to :owner, class_name: "User", foreign_key: :owner_id

    ROLES = {
        owner: "owner",
        guest: "guest",
        member: "member"
    }

    #walidacja na poziomie bazy danych
    # validates :title, presence: true

    def can_i_join?(role)
        role == ROLES.fetch(:guest)
    end

    def can_i_manage_event?(role)
        # binding.pry
        role == ROLES.fetch(:owner)
    end

    def can_i_quit?(role)
        role == ROLES.fetch(:member)
    end

    def role_for(user)
        return ROLES.fetch(:owner) if user.id == owner_id
        return ROLES.fetch(:member) if memberships.find_by(user: user).present?
        ROLES.fetch(:guest)
    end
end