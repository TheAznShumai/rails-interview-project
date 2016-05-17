class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user

  scope :accessible, -> { where(private: false) }
  scope :with_users, -> { includes(:user) }
  scope :with_answers, -> { includes(answers: :user) }
end
