require "test_helper"

class TrainingCheckInsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: "Training User",
      email: "training-user@example.com",
      password: "password",
      weight_goal: "lose_weight"
    )
    @headers = {
      "Authorization" => "Bearer #{JsonWebToken.encode(user_id: @user.id)}"
    }
  end

  test "returns default not trained status for today when missing" do
    get today_training_check_ins_url, headers: @headers

    assert_response :success
    body = response.parsed_body
    assert_equal Date.current.iso8601, body["date"]
    assert_equal false, body["trained"]
    assert_equal false, body["checked_in"]
    assert_equal [], body["activities"]
  end

  test "creates today's check-in" do
    assert_difference -> { @user.training_check_ins.count }, 1 do
      post today_training_check_ins_url,
        params: {
          training_check_in: {
            trained: true,
            activities: [ "strength", "cardio" ],
            notes: "Treino completo"
          }
        },
        headers: @headers
    end

    assert_response :success
    body = response.parsed_body
    assert_equal true, body["trained"]
    assert_equal true, body["checked_in"]
    assert_equal [ "strength", "cardio" ], body["activities"]
  end

  test "also accepts put for today's check-in" do
    assert_difference -> { @user.training_check_ins.count }, 1 do
      put today_training_check_ins_url,
        params: {
          training_check_in: {
            trained: true,
            activities: [ "walking", "other" ]
          }
        },
        headers: @headers
    end

    assert_response :success
    body = response.parsed_body
    assert_equal true, body["trained"]
    assert_equal [ "walking", "other" ], body["activities"]
  end

  test "updates today's check-in without creating another row" do
    @user.training_check_ins.create!(date: Date.current, trained: true, activities: [ "strength" ])

    assert_no_difference -> { @user.training_check_ins.count } do
      patch today_training_check_ins_url,
        params: {
          training_check_in: {
            trained: false,
            activities: [ "strength" ]
          }
        },
        headers: @headers
    end

    assert_response :success
    body = response.parsed_body
    assert_equal false, body["trained"]
    assert_equal [], body["activities"]
  end

  test "lists only current user's check-ins" do
    other_user = User.create!(
      name: "Other User",
      email: "other-training@example.com",
      password: "password",
      weight_goal: "gain_weight"
    )
    @user.training_check_ins.create!(date: Date.current, trained: true, activities: [ "walking" ])
    other_user.training_check_ins.create!(date: Date.current, trained: true, activities: [ "running" ])

    get training_check_ins_url, headers: @headers

    assert_response :success
    body = response.parsed_body
    assert_equal 1, body.length
    assert_equal @user.id, body.first["user_id"]
  end
end
