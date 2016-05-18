require 'rails_helper'

describe 'Questions API', type: :request do
  let(:tenant) { FactoryGirl.create(:tenant) }
  before { 20.times { FactoryGirl.create(:question, :with_answers) } }

  it 'returns an array of public questions' do
    get "/api/v1/questions.json?api_key=#{tenant.api_key}"
    question_count = Question.accessible.count
    json_item_count = JSON.parse(response.body)['questions'].size
    expect(json_item_count).to eq(question_count)
  end

  it 'returns a single question regardless if it is private or not' do
    id = Question.where(private: false).first.id
    get "/api/v1/questions/#{id}.json?api_key=#{tenant.api_key}"
    expect(response.body).not_to be_empty

    id = Question.where(private: true).first.id
    get "/api/v1/questions/#{id}.json?api_key=#{tenant.api_key}"
    expect(response.body).not_to be_empty
  end

  it 'allows you search for a question using the term param' do
    question = Question.accessible.first
    title = question.title.chop.chop # remove some chars; tests only bregex
    get "/api/v1/questions.json?api_key=#{tenant.api_key}&term=#{title}"
    results_ids = JSON.parse(response.body)['questions'].map{ |question| question['id'] }
    expect(results_ids).to include(question.id)
  end
end
