class GroupInvitationsController < ApplicationController
  before_action :authenticate_request
  before_action :set_invitation, only: [ :accept, :decline ]

  def index
    invitations = current_user.received_group_invitations
      .includes(:competition_group, :inviter, :invitee)
      .where(status: "pending")
      .order(created_at: :desc)

    render json: invitations.map { |invitation| serialize_invitation(invitation) }
  end

  def accept
    @invitation.accept!

    render json: serialize_invitation(@invitation)
  end

  def decline
    @invitation.decline!

    render json: serialize_invitation(@invitation)
  end

  private

    def set_invitation
      @invitation = current_user.received_group_invitations.find_by!(id: params[:id], status: "pending")
    end

    def serialize_invitation(invitation)
      invitation.as_json(only: [ :id, :status, :created_at, :responded_at ]).merge(
        "competition_group" => invitation.competition_group.as_json(only: [ :id, :name, :description, :ends_on ]),
        "invitee" => serialize_user(invitation.invitee),
        "inviter" => serialize_user(invitation.inviter)
      )
    end

    def serialize_user(user)
      user.as_json(only: [ :id, :name, :email ])
    end
end
