require "harbinger/engine" if defined?(Rails)
require "harbinger/version"
require "harbinger/reporters"
require "harbinger/channels"
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

  def build_message(options = {})
    contexts = Array(options.fetch(:contexts)).flatten.compact
    message = options.fetch(:message) { default_message }

    contexts.each { |context| reporter_for(context).accept(message) }
    message
  end

  def deliver_message(message, options = {})
    channels = options.fetch(:channels) { default_channels }
    Array(channels).flatten.compact.each do |channel_name|
      channel = channel_for(channel_name)
      channel.deliver(message)
    end
    true
  end

  def default_message
    require 'harbinger/message'
    Message.new
  end
  private_class_method :default_message

  def reporter_for(context)
    Reporters.find_for(context)
  end
  private_class_method :reporter_for

  def channel_for(name)
    Channels.find_for(name)
  end
  private_class_method :channel_for

  def default_channels
    configuration.default_channels
  end

  def logger
    configuration.logger
  end

  def database_storage
    configuration.database_storage
  end

end
