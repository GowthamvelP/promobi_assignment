FactoryBot.define do
  factory :tutor do
    name { Faker::Name.unique.name }
  end
end