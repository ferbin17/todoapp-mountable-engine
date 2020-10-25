$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "todoapp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "todoapp"
  spec.version     = Todoapp::VERSION
  spec.authors     = ["ferbin"]
  spec.email       = ["ferbin17@gmail.com"]
  spec.homepage    = "http://mygemserver.com"
  spec.summary     = "Change this later"
  spec.description = "Change this later"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.4"
  spec.add_dependency 'will_paginate'
  # Use SCSS for stylesheets
  spec.add_dependency 'sass-rails', '>= 6'
  # Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
  spec.add_dependency 'webpacker', '~> 4.0'
  # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
  spec.add_dependency 'turbolinks', '~> 5'
  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  spec.add_dependency 'jbuilder', '~> 2.7'

  spec.add_development_dependency "pg"
end
