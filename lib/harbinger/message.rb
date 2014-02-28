module Harbinger
  class Message
    def initialize
      @attributes = {}
    end

    def append(container, key, value)
      composite_key = "#{container}.#{key}"
      @attributes[composite_key] ||= []
      @attributes[composite_key] << value
    end

    attr_reader :attributes
  end
end