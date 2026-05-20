class GroupInvitation < ApplicationRecord
  STATUSES = %w[pending accepted declined].freeze

  belongs_to :competition_group
  belongs_to :inviter, class_name: "User"
  belongs_to :invitee, class_name: "User"

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :invitee_id, uniqueness: {
    scope: [ :competition_group_id, :status ],
    conditions: -> { where(status: "pending") }
  }
  validate :invitee_cannot_already_be_member, if: :pending?

  def pending?
    status == "pending"
  end

  def accept!
    transaction do
      competition_group.group_memberships.find_or_create_by!(user: invitee) do |membership|
        membership.role = "member"
      end
      update!(status: "accepted", responded_at: Time.current)
    end
  end

  def decline!
    update!(status: "declined", responded_at: Time.current)
  end

  private

    def invitee_cannot_already_be_member
      return unless competition_group.group_memberships.exists?(user: invitee)

      errors.add(:invitee, "is already a member")
    end
end
