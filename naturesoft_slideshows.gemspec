$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "naturesoft/slideshows/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "naturesoft_slideshows"
  s.version     = Naturesoft::Slideshows::VERSION
  s.authors     = ["Global Naturesoft"]
  s.email       = ["globalnaturesoft@gmail.com"]
  s.homepage    = "http://globalnaturesoft.com"
  s.summary     = "Slideshow feature for Naturesoft."
  s.description = "Slideshow feature for Naturesoft."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.0.0"
  s.add_dependency "naturesoft_core"

  s.add_dependency "deface"
end
