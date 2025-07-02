require 'redis'

$redis = Redis.new(url: ENV["UPSTASH_REDIS_URL"])

begin
  $redis.ping
  Rails.logger.info("✅ Redis connected successfully")
rescue => e
  Rails.logger.error("❌ Redis connection failed: #{e.message}")
end
