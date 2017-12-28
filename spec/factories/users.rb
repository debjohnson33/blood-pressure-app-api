FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    gender {Faker::Demographic.sex}
    birthdate { Faker::Date.birthday(18, 100) }
  end

end