uri = URI.parse(ENV["REDISTOGO_URL"])

if Rails.env == 'test'
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, db: 9)
else
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end