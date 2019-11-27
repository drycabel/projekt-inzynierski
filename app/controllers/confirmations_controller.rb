class ConfirmationsController < ApplicationController
    skip_before_action :authenticate_user, only: [:show]

    def show
        form = ConfirmationForm.new(token_params)
        if form.save
            redirect_to new_session_path, notice: "Account confirmed, now you can sign in"
        else
            redirect_to root_path, alert: form.errors.full_messages.join("\n")
        end
    end

    private

    def token_params
        params.permit(:token, :email)
    end

    class ConfirmationForm
        include ActiveModel::Model

        attr_accessor :token, :email

        validates :token, presence: true
        validate :user_presence
        validate :user_email_correctness
        validate :token_used
        validate :token_expiration

        def save
            return false unless valid?
            ActiveRecord::Base.transaction { call }
            true
        end

        private

        def call
            activate_token.deactivate
            user.confirm
        end

        def activate_token
            @activate_token ||= Token.find_by(value: token)
        end

        def user
            @user ||= activate_token&.user
        end

        def user_email_correctness
            return if !user.present?
            return if user.email.include?(email&.downcase)
            errors.add(:base, 'Provided email does not belongs to user!')
        end

        def token_expiration
            return unless activate_token&.expired?
            errors.add(:token, 'has expired')
        end

        def user_presence
            return if activate_token.blank? || user.present?
            errors.add(:base, 'Token does not have set existing user!')
        end

        def token_used
            return errors.add(:token, 'not found') unless activate_token.present?
            return if activate_token.active?
            errors.add(:token, 'has already been used')
        end

    end
end