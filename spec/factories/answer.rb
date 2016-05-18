FactoryGirl.define do
  factory :answer do
    body { FFaker::DizzleIpsum.sentence }
    question
    user
  end
end
