module RinTinTin
  class ApplicationController < ActionController::Base

    def index
      render text: '<h1>RinTinTin works</h1>', layout: true
    end
  end
end
