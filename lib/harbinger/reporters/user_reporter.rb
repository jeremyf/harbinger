module Harbinger::Reporters
  class UserReporter
    attr_reader :user, :method_names
    private :method_names

    def initialize(user, config = {})
      @user = user
      @method_names = config.fetch(:method_names) { ['username'] }
    end

    def accept(message)
      method_names.each do |method_name|
        if user.respond_to?(method_name)
          message.append('user', method_name, user.public_send(method_name))
        end
      end
    end

  end
end
