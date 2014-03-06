module Harbinger::Channels
  module LoggerChannel
    module_function
    def deliver(message, options = {})
      logger = options.fetch(:logger) { default_logger }
      severity = options.fetch(:severity) { default_severity }
      read(message) do |line|
        logger.add(severity, line)
      end
    end

    def read(message)
      yield("BEGIN MESSAGE OBJECT ID=#{message.object_id}")
      message.attributes.each do |key, value|
        yield("#{key.inspect} => #{value.inspect}")
      end
      yield("END MESSAGE OBJECT ID=#{message.object_id}")
    end
    private_class_method :read

    def default_logger
      Harbinger.logger
    end
    private_class_method :default_logger

    def default_severity
      5 # ::Logger::UNKNOWN
    end
    private_class_method :default_severity
  end
end
