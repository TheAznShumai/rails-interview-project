class Rack::Attack
  Rack::Attack.blacklist('block user without api_key') do |req|
    req.path.start_with?('/api') && !(req.params['api_key'] || request.headers['X-Api-Key'])
  end

  throttle('req/api_key/10', limit: 1, period: 10.seconds) do |req|
    if req.path.starts_with?('/api')
      # TODO: Add in enhancement to do this without hacks
      name = 'req/api_key/24'
      limit = 100
      period = 24.hours
      unprefixed_key = "#{name}:#{req.params['api_key']}"
      # See rack-attack/lib/rack/attack/cache.rb for how key is determined
      key = "#{(Time.now.to_i / period).to_i}:#{unprefixed_key}"
      attempts = Rack::Attack.cache.read(key) || 0
      new_key = req.params['api_key']
      if attempts.to_i < limit
        Rack::Attack.cache.count(unprefixed_key, period)
        new_key = nil
      end
      new_key
    end
  end
end
