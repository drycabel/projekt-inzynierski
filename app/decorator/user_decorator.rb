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

    delegate :email, to: :@object
    # delegate :email, :name, :surname, :birth_date, to: :@object

end