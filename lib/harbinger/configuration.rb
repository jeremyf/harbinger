require 'harbinger/exceptions'
module Harbinger
  class Configuration

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

    def default_logger
      if defined?(Rails)
        Rails.logger
      else
        require 'logger'
        ::Logger.new(STDOUT)
      end
    end
    private :default_logger

    def default_database_storage
      Class.new do
        def self.store_message(message)
        end
      end
    end
    private :default_database_storage


  end
end
