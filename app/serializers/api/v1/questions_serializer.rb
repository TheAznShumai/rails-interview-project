class Api::V1::QuestionsSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_one :user, root: :asker, serializer: Api::V1::UsersSerializer
  has_many :answers, embed: :objects, serializer: Api::V1::AnswersSerializer
end
