module Followed
  # helper method to generate redis keys
  def followed_redis_key(str)
    "#{self.class.to_s.downcase}:#{self.id}:#{str}"
  end

  # users that follow self
  def followers
    user_ids = $redis.smembers(self.followed_redis_key("user:followers"))
    User.where(id: user_ids)
  end

  # does the user follow self
  def followed_by?(user)
    $redis.sismember(self.followed_redis_key("user:followers"), user.id)
  end

  # number of followers
  def followers_count
    $redis.scard(self.followed_redis_key("user:followers"))
  end
end