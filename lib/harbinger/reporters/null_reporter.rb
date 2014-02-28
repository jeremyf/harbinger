module Harbinger::Reporters
  class NullReporter
    attr_reader :context

    def initialize(context, config = {})
      @context = context
    end

    def accept(message)
    end

  end
end
