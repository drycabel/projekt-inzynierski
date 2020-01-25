class UserDecorator

    def initialize(object)
        @object = object
    end

    def short_bio
        @object&.short_bio || "You don't have short biography. Edit profile and write something about yourself :)"
    end

    def name
        @object&.name || "Name"
    end

    def surname
        @object&.surname || "Surname"
    end

    def birth_date
        @object&.birth_date || "YYYY-MM-DD"
    end

    def age
        if @object.birth_date.present?
            now = Time.zone.now.to_date
            now.year - @object.birth_date.year - ((now.month > @object.birth_date.month || (now.month == @object.birth_date.month && now.day >= @object.birth_date.day)) ? 0 : 1)
        else
            "X"
        end
    end

    delegate :email, to: :@object
    # delegate :email, :name, :surname, :birth_date, to: :@object

end