class WelcomeController < ApplicationController
  def index
  end

  def dashboard
    @api_request_count = Tenant.sum(:api_count)
    @user_count = User.count
    @question_count = Question.count
    @answer_count = Answer.count
  end
end
