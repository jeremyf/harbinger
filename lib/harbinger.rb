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

  # Responsible for building a :message from the various :contexts and then
  # delivering the :message to the appropriate :channels.
  #
  # @see .build_message
  # @see .deliver_message
  #
  # @param [Hash] options
  # @option options [Message] :message The message you want to amend.
  #   If none is provided, then one is created.
  # @option options [Object, Array<Object>] :contexts One or more Objects that
  #   Harbinger will visit and extract message elements from.
  # @option options [Symbol, Array<Symbol>] :channels One or more channels that
  #   Harbinger will deliver the :message to
  def call(options)
    message = build_message(options)
    deliver_message(message, options)
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
