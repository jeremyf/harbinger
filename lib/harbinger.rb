require "harbinger/engine" if defined?(Rails)
require "harbinger/version"
require "harbinger/reporters"
require "harbinger/channels"
require "harbinger/exceptions"
require "harbinger/configuration"

module Harbinger
  class << self
    attr_writer :configuration

    # @see Configuration
    def configuration
      @configuration ||= Configuration.new
    end
  end

  module_function

  # @see Configuration
  # @see .configuration
  def configure
    yield(configuration)
  end

  # Responsible for building a :message from the various :reporters and then
  # delivering the :message to the appropriate :channels.
  #
  # @see .build_message
  # @see .deliver_message
  #
  # @param [Hash] options
  # @option options [Message] :message The message you want to amend.
  #   If none is provided, then one is created.
  # @option options [Object, Array<Object>] :reporters One or more Objects that
  #   Harbinger will visit and extract message elements from.
  # @option options [Symbol, Array<Symbol>] :channels One or more channels that
  #   Harbinger will deliver the :message to
  def call(options)
    message = build_message(options)
    deliver_message(message, options)
  end

  # Responsible for building a :message from the various :reporters.
  #
  # @see .call
  #
  # @param [Hash] options
  # @option options [Message] :message The message you want to amend.
  #   If none is provided, then one is created.
  # @option options [Object, Array<Object>] :reporters One or more Objects that
  #   Harbinger will visit and extract message elements from.
  def build_message(options = {})
    reporters = Array(options.fetch(:reporters)).flatten.compact
    message = options.fetch(:message) { default_message }

    reporters.each { |context| reporter_for(context).accept(message) }
    message
  end

  # Responsible for delivering a :message to the appropriate :channels.
  #
  # @see .call
  #
  # @param message [Message] The message you want to amend.
  #   If none is provided, then one is created.
  # @param [Hash] options
  # @option options [Symbol, Array<Symbol>] :channels One or more channels that
  #   Harbinger will deliver the :message to
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

  # @api protected
  def default_channels
    configuration.default_channels
  end

  # @api protected
  def logger
    configuration.logger
  end

  # @api protected
  def database_storage
    configuration.database_storage
  end


  # As per an isolated_namespace Rails engine.
  # But the isolated namespace creates issues.
  # @api private
  def table_name_prefix
    'harbinger_'
  end

  # Because I am not using isolate_namespace for Orcid::Engine
  # I need this for the application router to find the appropriate routes.
  # @api private
  def use_relative_model_naming?
    true
  end

end
