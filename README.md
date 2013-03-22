# NowPlay.us

## Requirements

Have Ruby 1.9.3 installed.

## Setup

- Run  ```bundle install```
- Run ```rake db:create db:migrate```

## Development

### To run locally

For a server ```bundle exec rails s```


For tests ```bundle exec rspec``` or ```bundle exec guard```

If you use guard, you get a few extras. For now I have guard set to not run the full suite unless you press Enter while it's running. Other than that it will only run the tests associated with the model/controller/etc that you've just modified. Benefit one: it auto-tests and you can leave it running. The other plus is LiveReload. To use LiveReload, you'll have to install the browser extension for [Chrome](https://chrome.google.com/extensions/detail/jnihajbhpnppcggbcgedagnkighmdlei) or [Safari](https://github.com/downloads/mockko/livereload/LiveReload-1.6.2.safariextz) then once you're viewing a route in the browser, click the extension button to start watching that route's view/css files.

