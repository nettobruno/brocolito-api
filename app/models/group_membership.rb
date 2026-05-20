class GroupMembership < ApplicationRecord
  ROLES = %w[owner member].freeze

  belongs_to :competition_group
  belongs_to :user

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :competition_group_id }
end
