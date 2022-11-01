FactoryBot.define do
  factory :course do
    title { Faker::Name.unique.name }
    description { Faker::Name.name }
  end
end