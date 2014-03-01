module Harbinger::Channels
  module LoggerChannel
    module_function
    def deliver(message, options = {})
      logger = options.fetch(:logger) { default_logger }
      severity = options.fetch(:severity) { default_severity }
      log_message = to_log_message(message)
      logger.add(severity, log_message)
    end

    def to_log_message(message)
      message.attributes.to_s
    end

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
