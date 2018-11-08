FactoryBot.define do
  factory :goal do
    systolic_bp { Faker::Number.between(80, 120) }
    diastolic_bp { Faker::Number.between(50, 80) }
    frequency "daily"
  end
end