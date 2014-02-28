require "harbinger/engine" if defined?(Rails)
require "harbinger/version"
require "harbinger/reporters"

module Harbinger
  module_function
  def reporter_for(context)
    Reporters.find_for(context)
  end
end
