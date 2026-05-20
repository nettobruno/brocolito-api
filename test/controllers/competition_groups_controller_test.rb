require "test_helper"

class CompetitionGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = User.create!(
      name: "Group Owner",
      email: "group-owner@example.com",
      password: "password",
      weight_goal: "lose_weight"
    )
    @member = User.create!(
      name: "Group Member",
      email: "group-member@example.com",
      password: "password",
      weight_goal: "lose_weight"
    )
    @owner_headers = auth_headers(@owner)
    @member_headers = auth_headers(@member)
  end

  test "creates a group with owner membership" do
    assert_difference -> { CompetitionGroup.count }, 1 do
      post competition_groups_url,
        params: {
          competition_group: {
            name: "Projeto Verão",
            description: "Treinar com constância",
            ends_on: 2.months.from_now.to_date
          }
        },
        headers: @owner_headers
    end

    assert_response :created
    body = response.parsed_body
    assert_equal "Projeto Verão", body["name"]
    assert_equal 1, body["member_count"]
    assert_equal @owner.id, body["owner"]["id"]
  end

  test "invites and accepts a user into a group" do
    group = create_group(@owner)

    assert_difference -> { GroupInvitation.count }, 1 do
      post invitations_competition_group_url(group),
        params: { invitation: { email: @member.email } },
        headers: @owner_headers
    end

    assert_response :created
    invitation_id = response.parsed_body["id"]

    post accept_group_invitation_url(invitation_id), headers: @member_headers

    assert_response :success
    assert group.members.exists?(@member.id)
  end

  test "returns ranking by trained check-ins" do
    group = create_group(@owner)
    group.update!(created_at: 3.days.ago)
    group.group_memberships.create!(user: @member)

    @owner.training_check_ins.create!(date: Date.current - 2.days, trained: true, activities: [ "strength" ])
    @owner.training_check_ins.create!(date: Date.current - 1.day, trained: true, activities: [ "walking" ])
    @member.training_check_ins.create!(date: Date.current - 1.day, trained: true, activities: [ "cardio" ])
    @member.training_check_ins.create!(date: Date.current, trained: false)

    get competition_group_url(group), headers: @owner_headers

    assert_response :success
    ranking = response.parsed_body["ranking"]
    assert_equal @owner.id, ranking.first["user"]["id"]
    assert_equal 2, ranking.first["trained_check_ins"]
    assert_equal @member.id, ranking.second["user"]["id"]
    assert_equal 1, ranking.second["trained_check_ins"]
    assert_equal 2, ranking.second["total_check_ins"]
  end

  test "lists pending invitations for current user" do
    group = create_group(@owner)
    group.group_invitations.create!(invitee: @member, inviter: @owner)

    get group_invitations_url, headers: @member_headers

    assert_response :success
    body = response.parsed_body
    assert_equal 1, body.length
    assert_equal group.id, body.first["competition_group"]["id"]
  end

  private

    def auth_headers(user)
      { "Authorization" => "Bearer #{JsonWebToken.encode(user_id: user.id)}" }
    end

    def create_group(owner)
      group = owner.created_competition_groups.create!(name: "Grupo Teste")
      group.group_memberships.create!(user: owner, role: "owner")
      group
    end
end
