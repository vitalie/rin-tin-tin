module RinTinTin
  class Webhook
    include Redis::Persistence

    #TODO: Allow in-app callbacks after create such as enqueuing a Resque job.
    #TODO: Fire ActiveSupport::Notifications during events.

    property :sender, default: '(Unknown)'

    property :headers
    property :body

    property :timestamp

    property :referrer

  end
end
