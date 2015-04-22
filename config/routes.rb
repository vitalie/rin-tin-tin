RinTinTin::Engine.routes.draw do

  root to: 'application#index'


  # Last route
  match ":sender", to: 'webhooks#create'
end
