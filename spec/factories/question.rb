FactoryGirl.define do
  factory :question do
    title { FFaker::DizzleIpsum.sentence }
    add_attribute(:private) { [true, false].sample }
    user

    trait :with_answers do
      transient do
        question_count 5
      end

      after(:build) do |question, evaluator|
        question.answers << build_list(:answer, evaluator.question_count, question: question)
      end
    end
  end
end
