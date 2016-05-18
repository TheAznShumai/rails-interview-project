FactoryGirl.define do
  factory :tenant do
    sequence(:name) { |n| "#{FFaker::Internet.user_name}#{n}" }
    api_count { 0 }
  end
end
