class Api::V1::QuestionsController < Api::ApiController
  def index
    @questions = Question.accessible.with_users.with_answers
    @questions = @questions.where('title LIKE ?', params[:term])
    render json: @questions, each_serializer: Api::V1::QuestionsSerializer
  end

  def show
    @question = Question.accessible.with_users.with_answers.find(params[:id])
    render json: @question, serializer: Api::V1::QuestionsSerializer
  end
end
