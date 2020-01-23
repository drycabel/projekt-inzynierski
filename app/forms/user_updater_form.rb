class UserUpdaterForm
    include ActiveModel::Model
    attr_accessor :email, :name, :surname, :birth_date, :short_bio, :logged_user, :user_id
    validates :email, :logged_user, :user_id, presence: true
    validate :user_is_a_logged_user

    def save
        return false unless valid?
        user.update!(name: name, surname: surname, birth_date: birth_date, short_bio: short_bio)
        true
    rescue => e
        errors.add(:base, "Something went wrong - #{e.inspect}")
        false
    end

    def user
        @user ||= User.find_by_id(user_id)
    end

    private

    def user_is_a_logged_user
        return if user&.id == logged_user.id
        errors.add(:base, "This is not your profile")
    end
end