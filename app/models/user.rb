class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :weight_goal, presence: true, inclusion: { in: %w[lose_weight gain_weight] }

  has_many :body_measurements, dependent: :destroy
end
