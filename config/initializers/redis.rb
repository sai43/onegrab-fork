require 'redis'

$redis = Redis.new(url: ENV["UPSTASH_REDIS_URL"], ssl: true)
puts "----> Redis PING: #{$redis.ping} <-------"
