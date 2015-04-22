require_dependency "rin_tin_tin/application_controller"

module RinTinTin
  class WebhooksController < ApplicationController

    def index
      render text: 'works'
    end

    def create
      hook = Webhook.new
      body = params.dup
      hook.sender = params.delete(:sender)

      body.delete(:action)
      body.delete(:controller)

      hook.body = body
      hook.timestamp = Time.now
      hook.referrer = request.referrer

      hook.headers = clean_headers
      if hook.save
        render nothing: true, status: :ok
      else
        render json: {error: "Could not save webhoook"}, status: :unprocessible_entity
      end
    end

    private

    def clean_headers
      #FIXME: This should use rack's raw text-only headers intead of the Ruby objects.

      orig_headers = request.headers.dup
      headers = {}
      good_keys = orig_headers.keys.reject do |key|
       key =~ /HTTP_COOKIE/ || key =~ /async\./ || key =~ /warden/ ||  key =~ /rack\./ || key =~ /action_dispatch\./ || key =~ /newrelic/ || key =~ /action_controller\./
      end

      good_keys.each do |key|
        begin
          headers[key] = orig_headers[key]
        rescue
          next
        end
      end
      headers
    end

  end
end
