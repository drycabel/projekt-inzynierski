class InvitationsRefuseController < ApplicationController
    skip_before_action :authenticate_user, only: :show

    def show
        # if @service.call
        #     redirect_to root_path, notice: "Invitation has been refused successfully"
        # else
        #     redirect_to root_path, alert: @service.errors.full_messages.join("\n")
        # end
        @email = invitation_refuse_params[:email]
        @service = InvitationRefuseService.new(invitation_refuse_params[:token_value])
        @service.call
    rescue => e
        @service.errors.add(:base, "Something went wrong #{e.inspect}")
    end



    private

    def invitation_refuse_params
        params.permit(:token_value, :email)
    end

end