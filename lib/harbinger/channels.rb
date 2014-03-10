module Harbinger
  module Channels
    module_function
    def find_for(channel_name)
      channel_class_name = channel_name_for_instance(channel_name)
      if const_defined?(channel_class_name)
        const_get(channel_class_name)
      else
        NullChannel
      end
    rescue StandardError
      NullReporter
    end

    def channel_name_for_instance(channel_name)
      channel_name.to_s.gsub(/(?:^|_)([a-z])/) { $1.upcase } + "Channel"
    end
    private_class_method :channel_name_for_instance
  end
end

require 'harbinger/channels/null_channel'
