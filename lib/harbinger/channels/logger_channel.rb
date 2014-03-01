module Harbinger::Channels
  module LoggerChannel
    module_function
    def deliver(message, options = {})
      logger = options.fetch(:logger) { default_logger }
      severity = options.fetch(:severity) { default_severity }

      logger.add(severity, message.to_s)
    end

    def default_logger
      Harbinger.logger
    end

    def default_severity
      5 # ::Logger::UNKNOWN
    end
  end
end
