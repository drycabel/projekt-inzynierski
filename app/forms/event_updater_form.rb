class EventUpdaterForm
    include ActiveModel::Model

    attr_accessor :title, :description, :owner, :event_id, :event_date, :event_time, :street, :city, :province, :zip
    validates :title, :description, :owner, :event_id, presence: true
    validate :title_uniqueness_for_owner
    validate :event_belongs_to_owner

    def save
        return false unless valid?
        event.update!(title: title, description: description, event_date: event_date, event_time: event_time)
        event.address.present? ? event.address.update!(city: city, street: street, province: province, zip: zip) : Address.create!(city: city, street: street, province: province, zip: zip, addressable: event)
        true
    rescue => e
        errors.add(:base, "Something went wrong - #{e.inspect}")
        #powyzej mozna uzyc Rollbar lub BugSnag
        false
    end

    def address
        @address ||= event.address
    end

    def event
        @event ||= Event.find(event_id)
    end

    private

    def title_uniqueness_for_owner
        return unless Event.where("owner_id = ? AND id != ?", owner.id, event.id).pluck(:title).map(&:downcase).include?(title.downcase)
        errors.add(:base, "You have already created event with provided title")
    end

    def event_belongs_to_owner
        return if event.owner_id == owner.id
        errors.add(:base, "You are not owner of this event")
    end


end