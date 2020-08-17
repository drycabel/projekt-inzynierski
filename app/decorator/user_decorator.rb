class UserDecorator

    def initialize(user)
        @user = user
    end

    def short_bio
        @user&.short_bio || "You don't have short biography. Edit profile and write something about yourself :)"
    end

    def name
        @user&.name || "Name"
    end

    def surname
        @user&.surname || "Surname"
    end

    def birth_date
        @user&.birth_date || "YYYY-MM-DD"
    end

    def age
        if @user.birth_date.present?
            now = Time.zone.now.to_date
            now.year - @user.birth_date.year - ((now.month > @user.birth_date.month || (now.month == @user.birth_date.month && now.day >= @user.birth_date.day)) ? 0 : 1)
        else
            "X"
        end
    end

    def short_email
        @user&.email&.truncate(16) || "-"
    end

    delegate :email, to: :@user
    # delegate :email, :name, :surname, :birth_date, to: :@user

end