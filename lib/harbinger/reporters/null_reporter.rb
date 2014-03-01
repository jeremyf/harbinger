module Harbinger::Reporters
  class NullReporter
    attr_reader :context

    def initialize(context, config = {})
      @context = context
    end

    def accept(message)
      message.append('nil', context.class.to_s, context.inspect)
    end

  end
end
