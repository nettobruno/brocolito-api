require "test_helper"

class TrainingCheckInTest < ActiveSupport::TestCase
  test "requires one check-in per user and date" do
    user = User.create!(
      name: "Check User",
      email: "check-user@example.com",
      password: "password",
      weight_goal: "lose_weight"
    )

    TrainingCheckIn.create!(user:, date: Date.current, trained: true, activities: [ "strength" ])
    duplicate = TrainingCheckIn.new(user:, date: Date.current, trained: false)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:date], "has already been taken"
  end

  test "clears activities when user did not train" do
    user = User.create!(
      name: "Rest User",
      email: "rest-user@example.com",
      password: "password",
      weight_goal: "lose_weight"
    )

    check_in = TrainingCheckIn.create!(
      user:,
      date: Date.current,
      trained: false,
      activities: [ "strength", "cardio" ]
    )

    assert_empty check_in.activities
  end

  test "rejects invalid activities" do
    user = User.create!(
      name: "Invalid Activity User",
      email: "invalid-activity@example.com",
      password: "password",
      weight_goal: "lose_weight"
    )

    check_in = TrainingCheckIn.new(
      user:,
      date: Date.current,
      trained: true,
      activities: [ "strength", "soccer" ]
    )

    assert_not check_in.valid?
    assert_includes check_in.errors[:activities], "contains invalid options"
  end
end
