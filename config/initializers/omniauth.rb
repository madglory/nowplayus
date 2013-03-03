if (Rails.env == 'production')
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    provider :twitter,  ENV['TWITTER_KEY'],  ENV['TWITTER_SECRET']
    provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  end
else
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    provider :twitter,  '6TkWHPR9ro1T5klnZ25deQ', 'WCYG2TFF11BgSW4eV3R1FwjcmpURxf0cfdy5EdgTQ'
    provider :facebook, '165078783642780', 'b81b4d258f49328516bb9cbc97b6aeef'
  end
end
