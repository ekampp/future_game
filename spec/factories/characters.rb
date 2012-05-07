# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character do
    name Faker::Name.name
    type "gladiator"
    energy 0
  end
end
