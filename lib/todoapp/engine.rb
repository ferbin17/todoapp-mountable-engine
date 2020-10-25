module Todoapp
  class Engine < ::Rails::Engine
    isolate_namespace Todoapp
    initializer "engine_name.assets.precompile" do |app|
      app.config.assets.precompile += %w(todoapp/application.js todoapp/application.css)
    end
  end
end
