require 'rails_helper'

describe 'API authentication', type: :request do
  let(:tenant) { FactoryGirl.create(:tenant) }

  it 'allows requests with api key as a param' do
    get "/api/v1/questions.json?api_key=#{tenant.api_key}"
    expect(response.status).to eq(200)
    expect(response.body).not_to be_empty
  end

  it 'allows requests with api key as a header' do
    headers = { 'X-Api-Key' => tenant.api_key }
    get '/api/v1/questions.json', nil, headers
    expect(response.status).to eq(200)
    expect(response.body).not_to be_empty
  end

  it 'denies a request without a api_key' do
    get '/api/v1/questions.json'
    expect(response.status).to eq(403)
  end

  it 'denies a request bad api_keys' do
    get '/api/v1/questions.json?api_key=123321'
    expect(response.status).to eq(401)
  end
end
