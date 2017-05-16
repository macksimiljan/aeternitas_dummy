redis_config = YAML::load_file(File.join(Rails.root, '/config/redis.yml'))
redis_url = {url: "redis://#{redis_config[:host]}:#{redis_config[:port]}"}

Sidekiq.configure_server do |config|
  config.redis = redis_url
end


Sidekiq.configure_client do |config|
  config.redis = redis_url
end
