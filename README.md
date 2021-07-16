# README


## Authenticate with http

### credentials encrypted

```bash
EDITOR="vim" bin/rails credentials:edit
```

```ruby
...
authentication:
  username: 'alan'
  password: 'senhaSecreta'

```

Testing on Rails c

```ruby

rails c

irb(main):001:0> Rails.application.credentials.authentication
=> {:username=>"alan", :password=>"senhaSecreta"}
irb(main):002:0> Rails.application.credentials.authentication[:username]
=> "alan"

```


```ruby

❯ vim app/controllers/application_controller.rb

# frozen_string_literal: true

# class ApplicationController
class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.authentication[:username] &&
        password == Rails.application.credentials.authentication[:password]
    end
  end
end

```
