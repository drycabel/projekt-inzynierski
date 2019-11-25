class Token < ApplicationRecord
    EXPIRATION_TIME = 60*60*24
    belongs_to :user
    def expired?
        (Time.current - created_at).to_i > EXPIRATION_TIME
      end
end