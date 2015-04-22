require 'rails_helper'

module RinTinTin
  RSpec.describe WebhooksController, :type => :controller do
    routes { RinTinTin::Engine.routes }

    before do
      Redis.current.flushdb
    end

    describe 'create' do
      it "records the webhook" do
        expect{post :create, {sender: 'paypal'}}.to change{RinTinTin::Webhook.all.size}.by(1)
      end

      it 'uses the url as the sender' do
        post :create, {sender: 'stripe'}

        expect(RinTinTin::Webhook.all.first.sender).to eql('stripe')
      end
    end
  end
end
