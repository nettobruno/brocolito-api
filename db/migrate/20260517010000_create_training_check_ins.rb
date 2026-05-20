class CreateTrainingCheckIns < ActiveRecord::Migration[8.1]
  def change
    create_table :training_check_ins do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.boolean :trained, null: false, default: false
      t.jsonb :activities, null: false, default: []
      t.text :notes

      t.timestamps
    end

    add_index :training_check_ins, [ :user_id, :date ], unique: true
  end
end
