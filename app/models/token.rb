class Token < ApplicationRecord
    EXPIRATION_TIME = 60 * 60 * 24

    before_create :generate_token

    belongs_to :ownerable, polymorphic: true

    def expired?
        (Time.current - created_at).to_i > EXPIRATION_TIME
    end

    def generate_token
        self.value = SecureRandom.uuid
    end

    def used?
        !active
    end
end