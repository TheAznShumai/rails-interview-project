class Api::ApiController < ActionController::Base
  before_action :authenticate
  before_action :track_api_request

  def current_tenant
    api_key = request.headers['X-Api-Key'] || params['api_key']
    return nil unless api_key
    @tenant ||= Tenant.where(api_key: api_key).first
  end

  def authenticate
    return true if current_tenant
    head status: :unauthorized
    false
  end

  def track_api_request
    current_tenant.increment(:api_count)
    current_tenant.save!
  end
end
