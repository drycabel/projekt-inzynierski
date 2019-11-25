class Invitation < ApplicationRecord
    belongs_to :event
    belongs_to :sender, class_name: 'User'
    belongs_to :recipent, class_name: 'User'
end