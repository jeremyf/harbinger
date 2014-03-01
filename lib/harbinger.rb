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
end
