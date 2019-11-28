class Invitation < ApplicationRecord
    after_create :generate_token

    belongs_to :event
    belongs_to :sender, class_name: 'User'
    belongs_to :recipent, class_name: 'User', optional: true
    has_many :tokens, as: :ownerable

    enum status: {
        sent: 10,
        accepted: 20,
        refused: 30,
    }

    def token
        tokens.last
    end

    private

    def generate_token
        self.tokens.create()
    end
end