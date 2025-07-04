require 'redis'
require 'uri'

# Fetch URL from env or fallback
redis_url = ENV.fetch("REDIS_URL") { "rediss://default:AStKAAIjcDFiOWE1ZmExYzhjMGY0OTAzYWFlMWJhMzhjY2RjMDgxZHAxMA@real-mule-11082.upstash.io:6379" }

# Parse the URL to check for scheme
uri = URI.parse(redis_url)

$redis = Redis.new(
  url: redis_url,
  ssl: uri.scheme == "rediss",
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
)

begin
  puts "✅ Redis connected! Ping: #{$redis.ping}"
rescue => e
  puts "❌ Redis connection failed: #{e.class} - #{e.message}"
end
