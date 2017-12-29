FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    gender {Faker::Demographic.sex}
    birthdate { "1989-03-02T00:00:00.000Z" } #Testing Faker birthday did not work so well
  end

end