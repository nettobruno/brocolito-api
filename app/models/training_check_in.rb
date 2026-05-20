class TrainingCheckIn < ApplicationRecord
  ACTIVITY_TYPES = %w[
    strength
    cardio
    pilates
    muay_thai
    running
    walking
    other
  ].freeze

  belongs_to :user

  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :trained, inclusion: { in: [ true, false ] }
  validates :activities, presence: true, if: :trained?
  validate :activities_must_be_valid

  before_validation :normalize_activities

  scope :ordered, -> { order(date: :desc) }
  scope :between_dates, ->(start_date, end_date) {
    relation = all
    relation = relation.where(date: start_date..) if start_date.present?
    relation = relation.where(date: ..end_date) if end_date.present?
    relation
  }

  def self.default_for(date)
    new(date: date, trained: false, activities: [])
  end

  private

    def normalize_activities
      self.activities = [] unless trained?
      self.activities = Array(activities).map(&:to_s).map(&:strip).reject(&:blank?).uniq
    end

    def activities_must_be_valid
      invalid_activities = Array(activities) - ACTIVITY_TYPES
      return if invalid_activities.empty?

      errors.add(:activities, "contains invalid options")
    end
end
