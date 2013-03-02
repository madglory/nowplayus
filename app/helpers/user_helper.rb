module UserHelper
  def user_twitter_link(user)
    "http://twitter.com/#{user.username}"
  end

  def user_facebook_link(user)
    "http://facebook.com/#{user.username}"
  end
end
