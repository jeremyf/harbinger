require "harbinger/engine" if defined?(Rails)
require "harbinger/version"
require "harbinger/reporters"
require "harbinger/exceptions"
require "harbinger/configuration"

module Harbinger
  module_function
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end
  end

  module_function
  def configure
    yield(configuration)
  end

  def call(options = {})
    contexts = Array(options.fetch(:contexts)).flatten.compact
    message = options.fetch(:message) { Message.new }

    contexts.each { |context| reporter_for(context).accept(message) }
    message
  end

  def deliver(message, options = {})
    channels = Array(options.fetch(:channels)).flatten.compact
    channels.each {|channel| channel.deliver(message) }
    true
  end


  def reporter_for(context)
    Reporters.find_for(context)
  end
  private_class_method :reporter_for

  def logger
    configuration.logger
  end

  def database_storage
    configuration.database_storage
  end

end
