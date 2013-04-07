module Following
  def following_redis_key(str)
    "#{self.class.to_s.downcase}:#{self.id}:#{str}"
  end

  # follow an object
  def follow!(object)
    $redis.multi do
      $redis.sadd(self.following_redis_key("#{object.class.to_s.downcase}:following"), object.id)
      $redis.sadd(object.followed_redis_key("#{self.class.to_s.downcase}:followers"), self.id)
    end
  end
  
  # unfollow a user
  def unfollow!(object)
    $redis.multi do
      $redis.srem(self.following_redis_key("#{object.class.to_s.downcase}:following"), object.id)
      $redis.srem(object.followed_redis_key("#{self.class.to_s.downcase}:followers"), self.id)
    end
  end

  # users who follow and are being followed by self
  def friends
    user_ids = $redis.sinter(self.following_redis_key('user:following'), self.following_redis_key('user:followers'))
    User.where(id: user_ids)
  end
  
  # does self follow user
  def following?(object)
    $redis.sismember(self.following_redis_key("#{object.class.to_s.downcase}:following"), object.id)
  end

  # number of users being followed
  def following_count(object_type = User)
    $redis.scard(self.following_redis_key("#{object_type.to_s.downcase}:following"))
  end
  
  # things that self follows
  def following(object_type = self)
    klass = object_class(object_type)
    object_ids = $redis.smembers(self.following_redis_key("#{klass.to_s.downcase}:following"))
    klass.where(id: object_ids)
  end
private
  def object_class(object_type)
    (object_type.class == String) ? object_type.singularize.capitalize.constantize : object_type.class
  end
end