class AddWeightGoalToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :weight_goal, :string, null: false, default: "lose_weight"
  end
end
