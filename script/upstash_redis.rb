require 'redis'
require 'uri'

redis_url = ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" }

uri = URI.parse(redis_url)

redis = Redis.new(
  url: redis_url,
  ssl: uri.scheme == "rediss",
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
)

begin
  puts "Pinging Redis..."
  puts "✅ Redis ping response: #{redis.ping}"
rescue => e
  puts "❌ Redis connection failed: #{e.class} - #{e.message}"
end

