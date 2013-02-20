module UserHelper
  def user_twitter_link(user)
    "http://twitter.com/#{user.username}"
  end
end
