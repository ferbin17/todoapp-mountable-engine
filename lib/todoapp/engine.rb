module Todoapp
  class Engine < ::Rails::Engine
    isolate_namespace Todoapp
    initializer "todoapp.assets.precompile" do |app|
      app.config.assets.precompile << "todoapp_manifest.js"
    end
  end
end
