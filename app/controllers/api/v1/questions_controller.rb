class Api::V1::QuestionsController < Api::ApiController
  def index
    @questions = Question.accessible.with_users.with_answers
    render json: @questions, each_serializer: Api::V1::QuestionsSerializer
  end

  def show
    @question = Question.accessible.with_users.with_answers.find(params[:id])
    render json: @question, serializer: Api::V1::QuestionsSerializer
  end
end
