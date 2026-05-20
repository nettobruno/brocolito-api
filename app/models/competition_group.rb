class CompetitionGroup < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :group_memberships, dependent: :destroy
  has_many :members, through: :group_memberships, source: :user
  has_many :group_invitations, dependent: :destroy

  validates :name, presence: true
  validate :ends_on_cannot_be_before_today, if: :new_record?

  def active_until
    [ ends_on, Date.current ].compact.min
  end

  def ranking
    period_start = created_at.to_date
    period_end = active_until

    members.map do |member|
      trained_check_ins = member.training_check_ins.where(date: period_start..period_end, trained: true).count
      total_check_ins = member.training_check_ins.where(date: period_start..period_end).count

      {
        user: member,
        trained_check_ins: trained_check_ins,
        total_check_ins: total_check_ins
      }
    end
      .sort_by { |entry| [ -entry[:trained_check_ins], -entry[:total_check_ins], entry[:user].name.downcase ] }
      .each_with_index
      .map { |entry, index| entry.merge(position: index + 1) }
  end

  private

    def ends_on_cannot_be_before_today
      return if ends_on.blank? || ends_on >= Date.current

      errors.add(:ends_on, "must be today or in the future")
    end
end
