module Harbinger
  class Message
    attr_reader :attributes
    def initialize
      @attributes = {}
    end

    def append(container, key, value)
      composite_key = "#{container}.#{key}"
      @attributes[composite_key] ||= []
      @attributes[composite_key] << value
    end

  end
end