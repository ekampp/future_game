# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| "#{n}#{Faker::Base.bothify("##??##??##")}" }
    provider Faker::Internet.user_name
    sequence(:email) { |n| "#{n}-#{Faker::Internet.email}" }
    role "player"
  end

  factory :admin, parent: :user do
    role "admin"
  end
end
