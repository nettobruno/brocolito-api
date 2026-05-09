admin = User.find_or_initialize_by(email: "admin@exemplo.com")
admin.name = "Admin"
admin.password = "123123" if admin.new_record?
admin.admin = true
admin.save!

bruno = User.find_or_initialize_by(email: "bruno@exemplo.com")
bruno.name = "Bruno"
bruno.password = "123123" if bruno.new_record?
bruno.admin = false
bruno.save!

julia = User.find_or_initialize_by(email: "julia@exemplo.com")
julia.name = "Julia"
julia.password = "123123" if julia.new_record?
julia.admin = false
julia.save!

bruno.body_measurements.destroy_all
julia.body_measurements.destroy_all

bruno.body_measurements.create!(
  weight_kg: 88.5,
  height_cm: 178,
  neck_circumference_cm: 40.0,
  chest_circumference_cm: 104.0,
  shoulder_circumference_cm: 118.0,
  waist_circumference_cm: 96.0,
  hip_circumference_cm: 102.0,
  abdomen_circumference_cm: 101.0,
  relaxed_arm_circumference_cm: 34.0,
  flexed_arm_circumference_cm: 37.0,
  forearm_circumference_cm: 29.0,
  thigh_circumference_cm: 61.0,
  calf_circumference_cm: 39.0,
  created_at: 3.months.ago,
  updated_at: 3.months.ago
)

bruno.body_measurements.create!(
  weight_kg: 84.2,
  height_cm: 178,
  neck_circumference_cm: 39.0,
  chest_circumference_cm: 102.0,
  shoulder_circumference_cm: 119.0,
  waist_circumference_cm: 90.0,
  hip_circumference_cm: 100.0,
  abdomen_circumference_cm: 94.0,
  relaxed_arm_circumference_cm: 35.0,
  flexed_arm_circumference_cm: 38.0,
  forearm_circumference_cm: 29.5,
  thigh_circumference_cm: 60.0,
  calf_circumference_cm: 38.5,
  created_at: 1.month.ago,
  updated_at: 1.month.ago
)

julia.body_measurements.create!(
  weight_kg: 64.0,
  height_cm: 165,
  neck_circumference_cm: 32.0,
  chest_circumference_cm: 89.0,
  shoulder_circumference_cm: 101.0,
  waist_circumference_cm: 74.0,
  hip_circumference_cm: 98.0,
  abdomen_circumference_cm: 82.0,
  relaxed_arm_circumference_cm: 28.0,
  flexed_arm_circumference_cm: 30.0,
  forearm_circumference_cm: 24.0,
  thigh_circumference_cm: 55.0,
  calf_circumference_cm: 35.0,
  created_at: 2.months.ago,
  updated_at: 2.months.ago
)

julia.body_measurements.create!(
  weight_kg: 62.7,
  height_cm: 165,
  neck_circumference_cm: 31.5,
  chest_circumference_cm: 88.0,
  shoulder_circumference_cm: 101.5,
  waist_circumference_cm: 71.0,
  hip_circumference_cm: 97.0,
  abdomen_circumference_cm: 79.0,
  relaxed_arm_circumference_cm: 28.5,
  flexed_arm_circumference_cm: 30.5,
  forearm_circumference_cm: 24.5,
  thigh_circumference_cm: 54.0,
  calf_circumference_cm: 34.5,
  created_at: 2.weeks.ago,
  updated_at: 2.weeks.ago
)

puts "Seeds created:"
puts "Admin: admin@exemplo.com / 123123"
puts "User: bruno@exemplo.com / 123123"
puts "User: julia@exemplo.com / 123123"
