module Harbinger
  module Reporters
    class RequestReporter
      attr_reader :request, :method_names
      private :method_names
      def initialize(request, config = {})
        @request = request
        @method_names = config.fetch(:method_names) { ['path', 'params', 'user_agent'] }
      end

      def accept(message)
        method_names.each do |method_name|
          if request.respond_to?(method_name)
            message.append('request', method_name, request.public_send(method_name))
          end
        end
      end
    end
  end
end
