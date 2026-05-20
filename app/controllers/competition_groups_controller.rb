class CompetitionGroupsController < ApplicationController
  before_action :authenticate_request
  before_action :set_group, only: [ :show, :invite ]

  def index
    groups = current_user.competition_groups.includes(:owner)

    render json: groups.map { |group| serialize_group(group) }
  end

  def show
    render json: serialize_group(@group, detailed: true)
  end

  def create
    group = current_user.created_competition_groups.new(group_params)

    CompetitionGroup.transaction do
      group.save!
      group.group_memberships.create!(user: current_user, role: "owner")
    end

    render json: serialize_group(group, detailed: true), status: :created
  rescue ActiveRecord::RecordInvalid
    render json: group.errors, status: :unprocessable_entity
  end

  def invite
    invitee = User.where("LOWER(email) = ?", invite_params[:email].to_s.downcase.strip).first

    unless invitee
      render json: { error: "User not found" }, status: :not_found
      return
    end

    invitation = @group.group_invitations.new(invitee: invitee, inviter: current_user)

    if invitation.save
      render json: serialize_invitation(invitation), status: :created
    else
      render json: invitation.errors, status: :unprocessable_entity
    end
  end

  private

    def set_group
      @group = current_user.competition_groups.find(params[:id])
    end

    def group_params
      params.require(:competition_group).permit(:name, :description, :ends_on)
    end

    def invite_params
      params.require(:invitation).permit(:email)
    end

    def serialize_group(group, detailed: false)
      payload = group.as_json(only: [ :id, :name, :description, :ends_on, :created_at, :updated_at ])
      payload["owner"] = serialize_user(group.owner)
      payload["member_count"] = group.group_memberships.count

      if detailed
        payload["members"] = group.group_memberships.includes(:user).map do |membership|
          serialize_user(membership.user).merge("role" => membership.role)
        end
        payload["ranking"] = group.ranking.map { |entry| serialize_ranking_entry(entry) }
        payload["pending_invitations"] = group.group_invitations
          .includes(:invitee)
          .where(status: "pending")
          .map { |invitation| serialize_invitation(invitation) }
      end

      payload
    end

    def serialize_ranking_entry(entry)
      {
        position: entry[:position],
        trained_check_ins: entry[:trained_check_ins],
        total_check_ins: entry[:total_check_ins],
        user: serialize_user(entry[:user])
      }
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
