require "kaminari"

module Harbinger
  class Engine < ::Rails::Engine
    engine_name 'harbinger'

    config.to_prepare do
      # Because I don't want to auto-require all of the dependent channels
      Harbinger.default_channels.each do |channel_name|
        require "harbinger/channels/#{channel_name}_channel"
      end
    end
  end
end
