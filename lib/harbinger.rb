require "harbinger/engine" if defined?(Rails)
require "harbinger/version"
require "harbinger/reporters"

module Harbinger
  module_function
  def reporter_for(context)
    Reporters.find_for(context)
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
end
