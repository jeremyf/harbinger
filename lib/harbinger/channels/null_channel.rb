module Harbinger::Channels
  module NullChannel
    module_function
    def deliver(message, options = {})
    end
  end
end
