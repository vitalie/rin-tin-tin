$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rin_tin_tin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rin-tin-tin"
  s.version     = RinTinTin::VERSION
  s.authors     = ["Jon Crawford"]
  s.email       = ["jon@storenvy.com"]
  s.homepage    = "http://www.storenvy.com"
  s.summary     = "Save webhooks into a Redis database for processing later."
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.19"
  s.add_dependency "redis"
  s.add_dependency 'redis-persistence'
  s.add_dependency 'redis-namespace'

  s.add_development_dependency "mysql2"

  s.add_development_dependency "rspec-rails", "~> 3.2.1"
  s.add_development_dependency "shoulda-matchers", "~>2.8"
  s.add_development_dependency "factory_girl_rails", "~> 4.5"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency 'byebug'
  # s.add_development_dependency "fakeredis"
end
