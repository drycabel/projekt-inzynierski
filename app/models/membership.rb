class Membership < ApplicationRecord

    belongs_to :user
    belongs_to :event

    enum role: {
        member: 10,
        owner: 20
    }

end