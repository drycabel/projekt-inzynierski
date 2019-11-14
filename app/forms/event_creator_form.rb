class EventCreatorForm
    include ActiveModel::Model

    attr_accessor :title, :description, :current_user
    validates :title, :description, :current_user, presence: true
    validate :title_uniqueness_for_owner

    def save
        return false unless valid?
        ActiveRecord::Base.transaction do 
            event = Event.create!(title: title, description: description, owner: current_user)
            Membership.create!(user: current_user, event: event, join_date: Time.now)
        end
        true
    
    rescue => e 
        errors.add(:base, "Something went wrong - #{e.inspect}")   
        #powyzej mozna uzyc Rollbar lub BugSnag 
        false 
    end

    private

    def title_uniqueness_for_owner
        return unless Event.where(owner: current_user).pluck(:title).map(&:downcase).include?(title.downcase)
        errors.add(:base, "You have already created event with provided title")
    end

end