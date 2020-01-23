class UpdatePasswordForm
    include ActiveModel::Model

    attr_accessor :old_password, :password, :password_re_type, :user_id, :current_user
    validates :old_password, :password, :password_re_type, :current_user, :user_id, presence: true
    validate :user_is_a_logged_user
    validate :new_password_is_different_than_old
    validate :rewrited_password_is_the_same

    def save
        return false unless valid?
        user.update!(password: password)
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
        return if user&.id == current_user.id
        errors.add(:base, "This is not your profile")
    end

    def new_password_is_different_than_old
        return if old_password != password
        errors.add(:base, "The new password must be different")
    end

    def rewrited_password_is_the_same
        return if password == password_re_type
        errors.add(:base, "The re-type password must be the same")
    end
end