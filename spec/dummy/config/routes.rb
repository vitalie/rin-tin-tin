Rails.application.routes.draw do

  mount RinTinTin::Engine, at: "/hooks"
end
