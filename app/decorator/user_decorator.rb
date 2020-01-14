class UserDecorator

    def initialize(object)
        @object = object
    end

    def short_bio
        @object&.short_bio || "You don't have short biography. Edit profile and write something about yourself :)"
    end

    delegate :email, :name, :surname, :age, to: :@object

end