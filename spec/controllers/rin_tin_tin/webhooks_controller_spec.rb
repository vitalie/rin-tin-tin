require 'rails_helper'

module RinTinTin
  RSpec.describe WebhooksController, :type => :controller do
    routes { RinTinTin::Engine.routes }

    before(:each) do
      RinTinTin.redis.redis.flushdb
    end

    describe 'create' do
      it "records the webhook" do
        post(:create, {sender: 'paypal', bacon: 'yes'}, {avacado: 'yes'})
        expect(response).to be_success
        expect{post(:create, {sender: 'paypal'})}.to change{RinTinTin::Webhook.all.size}.by(1)
      end

      it 'uses the url as the sender' do
        get :create, {sender: 'stripe', bacon: 'yes'}

        expect(RinTinTin::Webhook.all.first.sender).to eql('stripe')
      end

      it "sets body params" do
        post :create, {sender: 'paypal', wildebeast: 'yes'}
        expect(RinTinTin::Webhook.all.first.request_params[:wildebeast]).to be_present
      end

      it 'saves the path without params' do
        post :create, {sender: 'paypal', wildebeast: 'yes'}
        expect(RinTinTin::Webhook.all.first.path).to eql('/hooks/paypal')
      end
    end
  end
end
