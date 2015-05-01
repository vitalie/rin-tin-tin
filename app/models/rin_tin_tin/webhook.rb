module RinTinTin
  class Webhook
    include Redis::Persistence

    #TODO: Allow in-app callbacks after create such as enqueuing a Resque job.
    #TODO: Fire ActiveSupport::Notifications during events.

    property :sender, default: '(Unknown)'

    property :headers
    property :body
    property :request_params
    property :query_params
    property :query_string
    property :referrer
    property :method
    property :path

    property :timestamp

    def self.ids
      RinTinTin.redis.keys('rin_tin_tin_webhooks:*').map do |key|
        key.split(':').last.to_i
      end
    end

    def self.size
      RinTinTin.redis.keys('rin_tin_tin_webhooks:*').size
    end

  end
end
