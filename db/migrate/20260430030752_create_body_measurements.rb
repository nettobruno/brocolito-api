class CreateBodyMeasurements < ActiveRecord::Migration[8.1]
  def change
    create_table :body_measurements do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :weight_kg
      t.integer :height_cm
      t.decimal :neck_circumference_cm
      t.decimal :chest_circumference_cm
      t.decimal :shoulder_circumference_cm
      t.decimal :waist_circumference_cm
      t.decimal :hip_circumference_cm
      t.decimal :abdomen_circumference_cm
      t.decimal :relaxed_arm_circumference_cm
      t.decimal :flexed_arm_circumference_cm
      t.decimal :forearm_circumference_cm
      t.decimal :thigh_circumference_cm
      t.decimal :calf_circumference_cm

      t.timestamps
    end
  end
end
