FactoryBot.define do
  factory :measurement do
    systolic_bp { Faker::Number.between(80, 250) }
    diastolic_bp { Faker::Number.between(50, 150) }
    pulse { Faker::Number.between(40, 120) }
    date_time { Faker::Time.between(2.days.ago, Date.today, :day) }
    notes { Faker::Lorem.sentence }
  end

end