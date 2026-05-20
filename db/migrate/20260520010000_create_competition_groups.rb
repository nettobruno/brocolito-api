class CreateCompetitionGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :competition_groups do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.text :description
      t.date :ends_on

      t.timestamps
    end

    create_table :group_memberships do |t|
      t.references :competition_group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false, default: "member"

      t.timestamps
    end

    add_index :group_memberships, [ :competition_group_id, :user_id ], unique: true

    create_table :group_invitations do |t|
      t.references :competition_group, null: false, foreign_key: true
      t.references :inviter, null: false, foreign_key: { to_table: :users }
      t.references :invitee, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false, default: "pending"
      t.datetime :responded_at

      t.timestamps
    end

    add_index :group_invitations,
      [ :competition_group_id, :invitee_id, :status ],
      unique: true,
      where: "status = 'pending'"
  end
end
