# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Nowplayus::Application.config.secret_token = ENV['SECRET_TOKEN'] || '9f048fda6dd50421baffe6930f52664fa666650c5279c5ef1d122bc23a6390ea17dc280fdb6ebe06675cc46771542f0fdcfce974084a3eefed4ce42153ae903a'
