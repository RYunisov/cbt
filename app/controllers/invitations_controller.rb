#encoding: UTF-8
class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  # GET /invitations/new
  def new
    if signed_in?
      @invitation = Invitation.new
    else
      redirect_to root_path
    end    
  end

  # POST /invitations
  def create
    if signed_in?
      @invitation = Invitation.new(invitation_params)
      @invitation.sender = current_user
      if @invitation.save
        Mailer.invitation(@invitation, signup_with_token_url(@invitation.token)).deliver
        redirect_to current_user, notice: 'Спасибо, приглашение отправлено.'
      else
        render action: 'new'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invitation_params
      params.require(:invitation).permit(:sender_id, :recipient_email, :token, :send_at, :new)
    end
end
