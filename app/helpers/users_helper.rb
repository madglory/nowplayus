module UsersHelper

  def twitter_url(user)
    "http://twitter.com/#{user.username}"
  end
end
