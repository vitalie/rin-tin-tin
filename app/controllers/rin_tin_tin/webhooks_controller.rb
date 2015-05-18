require_dependency "rin_tin_tin/application_controller"

module RinTinTin
  class WebhooksController < ApplicationController

    def index
      render text: 'works'
    end

    def create
      hook = Webhook.new
      hook.sender = request.path_parameters["sender"]
      hook.body = request.body.read
      hook.request_params = request.request_parameters
      hook.query_string = request.query_string
      hook.query_params = request.query_parameters
      hook.timestamp = Time.now
      hook.referrer = request.referrer
      hook.method = request.method
      hook.path = request.fullpath

      hook.headers = clean_headers
      if hook.save
        render nothing: true, status: :ok
      else
        render json: {error: "Could not save webhook"}, status: :unprocessable_entity
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
