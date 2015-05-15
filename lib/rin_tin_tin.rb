require "rin_tin_tin/engine"

module RinTinTin
  extend self

  def redis=(server)
    case server
    when String
      if server =~ /redis\:\/\//
        redis = Redis.connect(:url => server, :thread_safe => true)
      else
        server, namespace = server.split('/', 2)
        host, port, db = server.split(':')
        redis = Redis.new(:host => host, :port => port,
          :thread_safe => true, :db => db)
      end
      namespace ||= :rin_tin_tin

      @redis = Redis::Namespace.new(namespace, :redis => redis)
    when Redis::Namespace
      @redis = server
    else
      @redis = Redis::Namespace.new(:rin_tin_tin, :redis => server)
    end
    Redis::Persistence.config.redis = @redis
  end

  # Returns the current Redis connection. If none has been created, will
  # create a new one.
  def redis
    return @redis if @redis
    self.redis = Redis.respond_to?(:connect) ? Redis.connect : "localhost:6379"
    self.redis
  end

  def redis_id
    # support 1.x versions of redis-rb
    if redis.respond_to?(:server)
      redis.server
    elsif redis.respond_to?(:nodes) # distributed
      redis.nodes.map { |n| n.id }.join(', ')
    else
      redis.client.id
    end
  end
end
