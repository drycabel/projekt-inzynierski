class UserDestroyerService
    attr_reader :msg

    def initialize(user_id, current_user)
        @current_user = current_user
        @user_id = user_id
    end

    def user
        return @user if defined? @user
        @user = User.find_by(id: @user_id)
    end

    def destroyed_successfully?
        return false unless validations_succeed?
        user.destroy!
        send_email
        @msg = "Account destroyed successfully"
        true
    rescue => e
        @msg = "Something went wrong - #{e.inspect}"
        false
    end

    def send_email
        UsersDestroyMailer.call(user).deliver!
    end

    private

    def validations_succeed?
        @msg = "You have to be logged in" and return false if @current_user.blank?

        @msg = "User doesn't exist" and return false if user.blank?

        @msg = "This is not your account" and return false if user.id != @current_user.id

        true
    end
end