module Harbinger::Reporters
  class ExceptionReporter
    attr_reader :exception

    def initialize(exception)
      @exception = exception
    end

    def accept(message)

      if exception.respond_to?(:class)
        message.append('exception', 'class_name', exception.class.to_s)
      end

      if exception.respond_to?(:backtrace)
        message.append('exception', 'backtrace', Array(exception.backtrace).join("\n"))
      end

      if exception.respond_to?(:message)
        message.append('exception', 'message', exception.message)
      end

    end

  end
end
