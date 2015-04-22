# RinTinTin

[![Circle CI](https://circleci.com/gh/Storenvy/rin-tin-tin.svg?style=svg)](https://circleci.com/gh/Storenvy/rin-tin-tin)

### "It's the hook that brings you BAAAAACK."

<a href="http://www.youtube.com/watch?feature=player_embedded&v=pdz5kCaCRFM
" target="_blank"><img src="http://img.youtube.com/vi/pdz5kCaCRFM/0.jpg"
alt="IMAGE ALT TEXT HERE" width="420" height="315" border="10" /></a>

## Under Development

This is not yet available on Rubygems.org as it's not complete. Although the functionality that is works well.


## What does it do?

Receiving webhooks is a delicate thing. Sometimes webhooks contain vital data and event notifications that are a must-have to keep your app's business logic in sync with the rest of your integration partners. But sometimes we drop the ball on these webhooks because our app has an exception while we're handling it or something else unexpected.

RinTinTin saves inbound webhooks to an ActiveModel-based Redis store for processing later.

```ruby
RinTinTin::Webhoook.all.first.attributes =>
{
  "id"=>333, # An auto-incrementing ID in Redis.
  "sender"=>"PayPal", # The sender of the webhoook based on the url you define (e.g. "/hooks/PayPal")
  "headers"=> { # The headers pulled from the request.
    "Content-Type" => "application/json"
  },
  "body"=> {
    "event-name" => "shipped"
  },
  "timestamp"=> "2015-04-22T12:00:44-07:00", # Currently a string. This will be a `DateTime` object in a later version.
  "referrer"=> nil # The HTTP referrer of the request.
}

```

## Installation
`gem "rin-tin-tin", github: "Storenvy/rin-tin-tin"`

## Usage
In your app's route file:

`mount RinTinTin::Engine, at: '/hooks'`

You can specify any route you'd like for the engine. I chose "/hooks" because it's short.

Now you can send webhooks to any url after '/hooks' such as http://yourapp.com/hooks/PayPal.

### Find and work jobs

```ruby
RinTinTin::Webhook.all.each do |webhook|
  # Process your webhook
  if webhook.sender == 'PayPal' # <- Based on the URL you created, remember?
    # Do important stuff.
    # ...
    # Then dismiss it when you're done.
    webhook.destroy
  end
end
```

## Dependencies
* Ruby on Rails (Tested with Rails 3.2.14)
* Redis
* Currently relies heavily on [redis-persistence](https://github.com/socialinsider/redis-persistence) but will not require this dependency in a later version.

## TODO

* Create Worker class that your app's workers can inherit from for processing.
* Cast timestamps as DateTime objects.
* Allow your app to define callbacks for certain webhoook "senders". Callback usage could include enqueing a Resque job for processing the webhook.
* Fire `ActiveSupport::Notification`s during creation and deletion.
* Create another key for storing processed webhooks for reference later.
* Build authenticated UI for browsing webhooks like resque-web.
* Remove redis-persistence.
