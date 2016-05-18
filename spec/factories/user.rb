FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "#{FFaker::Internet.user_name}#{n}" }
  end
end
