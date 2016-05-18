class Api::V1::AnswersSerializer < ActiveModel::Serializer
  attributes :id, :question_id, :body
  has_one :user, root: :answerer, serializer: Api::V1::UsersSerializer
end
