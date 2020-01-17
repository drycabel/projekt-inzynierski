class EventCreatorForm
    include ActiveModel::Model

    attr_accessor :title, :description, :current_user, :event_date, :event_time, :street, :city, :province, :zip
    validates :title, :description, :current_user, presence: true
    validate :title_uniqueness_for_owner

    def save
        return false unless valid?
        ActiveRecord::Base.transaction do
            event.save!
            Address.create!(city: city, street: street, province: province, zip: zip, addressable: event)
            Membership.create!(user: current_user, event: event, join_date: Time.now, role: 20)
        end
        true

    rescue => e
        errors.add(:base, "Something went wrong - #{e.inspect}")
        false
    end

    def event
        @event ||= Event.new(title: title, description: description, event_date: event_date, event_time: event_time, owner: current_user)
    end

    private

    def title_uniqueness_for_owner
        return unless Event.where(owner: current_user).pluck(:title).map(&:downcase).include?(title.downcase)
        errors.add(:base, "You have already created event with provided title")
    end

end