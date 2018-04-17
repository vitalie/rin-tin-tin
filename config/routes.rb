RinTinTin::Engine.routes.draw do

  root to: 'application#index'


  # Last route
  post ":sender", to: 'webhooks#create'
end
