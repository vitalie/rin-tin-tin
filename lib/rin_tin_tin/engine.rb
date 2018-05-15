module RinTinTin
  class Engine < ::Rails::Engine
    isolate_namespace RinTinTin

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
      g.template_engine :slim
    end

    config.action_controller.action_on_unpermitted_parameters :raise

    config.autoload_paths += ["#{RinTinTin::Engine.root}/app/controllers/concerns"]
    config.autoload_paths += ["#{RinTinTin::Engine.root}/app/models/concerns"]

    I18n.enforce_available_locales = true

  end
end
