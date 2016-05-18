require 'rails_helper'

describe 'Api Throttling', type: :request do
  let(:tenant) { FactoryGirl.create(:tenant) }

  it 'allows a tenant 100 request (within 24 hours) + 1 request per 10 seconds' do
    100.times { get "/api/v1/questions.json?api_key=#{tenant.api_key}" }

    get "/api/v1/questions.json?api_key=#{tenant.api_key}"
    expect(response.status).to eq(200)

    get "/api/v1/questions.json?api_key=#{tenant.api_key}"
    expect(response.status).to eq(429)
    sleep 10.seconds

    get "/api/v1/questions.json?api_key=#{tenant.api_key}"
    expect(response.status).to eq(200)
  end
end
