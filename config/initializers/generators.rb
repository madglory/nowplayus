Rails.application.config.generators do |g|
  g.controller_specs false
  g.view_specs false
  g.helper_specs false
  g.fixture_replacement :factory_girl
  g.test_framework :rspec, :views => false, :fixture => true
  g.template_engine :haml
  g.stylesheets false
end