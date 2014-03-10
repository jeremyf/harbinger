require 'harbinger/exceptions'
module Harbinger
  class Configuration

    def initialize(collaborators = {})
      self.logger = collaborators.fetch(:logger) { default_logger }
      self.database_storage = collaborators.fetch(:database_storage) { default_database_storage }
    end

    attr_reader :logger

    def default_logger
      if defined?(Rails)
        Rails.logger
      else
        require 'logger'
        ::Logger.new(STDOUT)
      end
    end
    private :default_logger

    def logger=(object)
      raise ConfigurationError.new("Expected Harbinger.database_storage to respond_to #add. #{object.inspect} does not respond to #add") unless object.respond_to?(:add)
      @logger = object
    end
    protected :logger=

    attr_reader :database_storage

    def default_database_storage
      Class.new do
        def self.store_message(message)
        end
      end
    end
    private :default_database_storage

    def database_storage=(object)
      raise ConfigurationError.new("Expected Harbinger.database_storage to respond_to #store_message. #{object.inspect} does not respond to #add") unless object.respond_to?(:store_message)
      @database_storage = object
    end
    protected :database_storage=

  end
end
