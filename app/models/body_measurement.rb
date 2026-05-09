class BodyMeasurement < ApplicationRecord
  OPTIONAL_MEASUREMENTS = %i[
    neck_circumference_cm
    chest_circumference_cm
    shoulder_circumference_cm
    waist_circumference_cm
    hip_circumference_cm
    abdomen_circumference_cm
    relaxed_arm_circumference_cm
    flexed_arm_circumference_cm
    forearm_circumference_cm
    thigh_circumference_cm
    calf_circumference_cm
  ].freeze

  belongs_to :user

  validates :weight_kg, presence: true, numericality: { greater_than: 0 }
  validates :height_cm, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates *OPTIONAL_MEASUREMENTS, numericality: { greater_than: 0 }, allow_nil: true
end
