# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  end

  factory :admin, parent: :user do
    role "admin"
  end
end
