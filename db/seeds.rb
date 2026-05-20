admin = User.find_or_initialize_by(email: "admin@exemplo.com")
admin.name = "Admin"
admin.password = "123123" if admin.new_record?
admin.admin = true
admin.weight_goal = "lose_weight"
admin.save!

bruno = User.find_or_initialize_by(email: "bruno@exemplo.com")
bruno.name = "Bruno"
bruno.password = "123123" if bruno.new_record?
bruno.admin = false
bruno.weight_goal = "gain_weight"
bruno.save!

julia = User.find_or_initialize_by(email: "julia@exemplo.com")
julia.name = "Julia"
julia.password = "123123" if julia.new_record?
julia.admin = false
julia.weight_goal = "lose_weight"
julia.save!

marina = User.find_or_initialize_by(email: "marina@exemplo.com")
marina.name = "Marina Progresso"
marina.password = "123123" if marina.new_record?
marina.admin = false
marina.weight_goal = "lose_weight"
marina.save!

bruno.body_measurements.destroy_all
julia.body_measurements.destroy_all
marina.body_measurements.destroy_all
marina.training_check_ins.destroy_all

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

marina_measurements = [
  [ Date.new(2026, 1, 2), 120.0, 43.0, 122.0, 118.0, 112.0, 126.0, 121.0, 39.0, 42.0, 32.0, 71.0, 45.0 ],
  [ Date.new(2026, 1, 16), 117.8, 42.4, 120.2, 118.2, 108.8, 124.0, 117.8, 38.6, 41.7, 31.8, 70.2, 44.5 ],
  [ Date.new(2026, 1, 30), 115.9, 41.9, 118.5, 118.4, 106.2, 122.5, 115.2, 38.4, 41.6, 31.7, 69.6, 44.1 ],
  [ Date.new(2026, 2, 13), 113.6, 41.3, 116.8, 118.5, 103.5, 120.6, 112.4, 38.1, 41.5, 31.6, 68.8, 43.6 ],
  [ Date.new(2026, 2, 27), 111.9, 40.8, 115.2, 118.8, 101.8, 119.0, 110.5, 37.9, 41.5, 31.5, 68.2, 43.2 ],
  [ Date.new(2026, 3, 13), 109.8, 40.3, 113.8, 119.0, 99.6, 117.4, 108.0, 37.6, 41.4, 31.3, 67.5, 42.8 ],
  [ Date.new(2026, 3, 27), 108.2, 39.8, 112.7, 119.3, 98.0, 116.1, 106.3, 37.4, 41.5, 31.2, 66.9, 42.4 ],
  [ Date.new(2026, 4, 10), 106.5, 39.4, 111.4, 119.5, 96.5, 114.8, 104.6, 37.2, 41.6, 31.2, 66.3, 42.0 ],
  [ Date.new(2026, 4, 24), 105.1, 39.0, 110.6, 119.8, 95.1, 113.6, 103.2, 37.1, 41.7, 31.1, 65.8, 41.7 ],
  [ Date.new(2026, 5, 8), 103.8, 38.7, 109.8, 120.0, 93.8, 112.6, 101.9, 37.0, 41.8, 31.1, 65.4, 41.4 ],
  [ Date.new(2026, 5, 20), 102.9, 38.4, 109.0, 120.2, 92.7, 111.8, 100.8, 36.9, 42.0, 31.0, 65.0, 41.1 ]
]

marina_measurements.each do |date, weight, neck, chest, shoulder, waist, hip, abdomen, relaxed_arm, flexed_arm, forearm, thigh, calf|
  measured_at = date.change(hour: 7, min: 30)

  marina.body_measurements.create!(
    weight_kg: weight,
    height_cm: 170,
    neck_circumference_cm: neck,
    chest_circumference_cm: chest,
    shoulder_circumference_cm: shoulder,
    waist_circumference_cm: waist,
    hip_circumference_cm: hip,
    abdomen_circumference_cm: abdomen,
    relaxed_arm_circumference_cm: relaxed_arm,
    flexed_arm_circumference_cm: flexed_arm,
    forearm_circumference_cm: forearm,
    thigh_circumference_cm: thigh,
    calf_circumference_cm: calf,
    created_at: measured_at,
    updated_at: measured_at
  )
end

training_plan = {
  1 => [ "walking" ],
  2 => [ "strength" ],
  4 => [ "cardio", "walking" ],
  5 => [ "strength" ],
  6 => [ "walking", "pilates" ]
}

(Date.new(2026, 1, 1)..Date.new(2026, 5, 20)).each do |date|
  next if date.wday == 0

  activities = training_plan.fetch(date.wday, [])
  trained = activities.any?
  checked_at = date.change(hour: 20, min: 15)

  marina.training_check_ins.create!(
    date: date,
    trained: trained,
    activities: activities,
    notes: trained ? "Check-in seed: treino concluído dentro do plano." : "Check-in seed: descanso ativo e recuperação.",
    created_at: checked_at,
    updated_at: checked_at
  )
end

puts "Seeds created:"
puts "Admin: admin@exemplo.com / 123123"
puts "User: bruno@exemplo.com / 123123"
puts "User: julia@exemplo.com / 123123"
puts "User: marina@exemplo.com / 123123"
