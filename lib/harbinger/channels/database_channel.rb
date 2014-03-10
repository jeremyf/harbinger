module Harbinger::Channels
  module DatabaseChannel
    module_function
    def deliver(message, options = {})
      storage = options.fetch(:storage) { default_storage }
      storage.store_message(message)
    end

    def default_storage
      Harbinger.database_storage
    end
    private_class_method :default_storage

  end
end
