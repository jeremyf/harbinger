require 'harbinger/exceptions'
module Harbinger
  class Configuration

    def default_channels
      @default_channels || __default_channels
    end

    def default_channels=(*channel_names)
      @default_channels = Array(channel_names).flatten.compact.collect{|name|
        word = name.to_s
        word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
        word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        word.tr!("-", "_")
        word.downcase!
        word.to_sym
      }
    end

    def logger
      @logger || default_logger
    end

    def logger=(object)
      raise ConfigurationError.new("Expected Harbinger.database_storage to respond_to #add. #{object.inspect} does not respond to #add") unless object.respond_to?(:add)
      @logger = object
    end

    def database_storage
      @database_storage || default_database_storage
    end

    def database_storage=(object)
      raise ConfigurationError.new("Expected Harbinger.database_storage to respond_to #store_message. #{object.inspect} does not respond to #add") unless object.respond_to?(:store_message)
      @database_storage = object
    end

    private

    def default_logger
      if defined?(Rails)
        Rails.logger
      else
        require 'logger'
        ::Logger.new(STDOUT)
      end
    end

    def default_database_storage
      Class.new do
        def self.store_message(message)
        end
      end
    end

    def __default_channels
      [:logger]
    end
  end
end
