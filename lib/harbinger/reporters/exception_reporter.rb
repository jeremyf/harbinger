module Harbinger::Reporters
  class ExceptionReporter
    attr_reader :exception

    def initialize(exception)
      @exception = exception
    end

    def accept(message)
      message.append('exception', 'class_name', exception.class.to_s)
      message.append('exception', 'backtrace', Array(exception.backtrace).join("\n"))
      message.append('exception', 'message', exception.message)
    end

  end
end
