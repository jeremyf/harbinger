require 'rails/generators'
module Harbinger
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    class_option :skip_database_channel, default: false, type: :boolean

    def install_database_channel
      if ! options[:skip_database_channel]
        rake 'harbinger:install:migrations'
      end
    end

    def install_configuration_file
      template "harbinger_initializer.rb.erb", "config/initializers/harbinger_initializer.rb"
    end

    def install_routes
      route 'mount Harbinger::Engine => "/harbinger"'
    end

  end
end