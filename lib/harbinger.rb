require "harbinger/engine" if defined?(Rails)
require "harbinger/version"
require "harbinger/reporters"

module Harbinger
  module_function

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
    @logger ||= default_logger
  end

  def default_logger
    if defined?(Rails)
      Rails.logger
    else
      require 'logger'
      ::Logger.new(STDOUT)
    end
  end
  private_class_method :default_logger

  def database_storage
    @database_storage ||= default_database_storage
  end

  def default_database_storage
    @default_database_storage ||= Class.new {
      def self.store_message(message)
      end
    }
  end
  private_class_method :default_database_storage

end
