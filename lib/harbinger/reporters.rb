module Harbinger
  module Reporters
    module_function
    def find_for(context)
      if context.respond_to?(:to_harbinger_reporter)
        context.to_harbinger_reporter
      else
        # @TODO - Handle inheritence; KeyError is not an Exception
        reporter_class_name = reporter_name_for_instance(context)
        if const_defined?(reporter_class_name)
          const_get(reporter_class_name).new(context)
        else
          NullReporter.new(context)
        end
      end
    rescue StandardError
      NullReporter.new(context)
    end

    def reporter_name_for_instance(context)
      if context.is_a?(Exception)
        "ExceptionReporter"
      else
        context.class.to_s.split('::').last.gsub(/(?:^|_)([a-z])/) { $1.upcase } + "Reporter"
      end
    end
    private_class_method :reporter_name_for_instance
  end
end

require "harbinger/reporters/user_reporter"
require "harbinger/reporters/request_reporter"
require "harbinger/reporters/exception_reporter"
require "harbinger/reporters/null_reporter"
