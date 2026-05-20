class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :weight_goal, presence: true, inclusion: { in: %w[lose_weight gain_weight] }

  has_many :body_measurements, dependent: :destroy
  has_many :training_check_ins, dependent: :destroy
  has_many :created_competition_groups, class_name: "CompetitionGroup", foreign_key: :owner_id, dependent: :destroy
  has_many :group_memberships, dependent: :destroy
  has_many :competition_groups, through: :group_memberships
  has_many :sent_group_invitations, class_name: "GroupInvitation", foreign_key: :inviter_id, dependent: :destroy
  has_many :received_group_invitations, class_name: "GroupInvitation", foreign_key: :invitee_id, dependent: :destroy
end
