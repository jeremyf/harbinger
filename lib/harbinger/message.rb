module Harbinger
  class Message
    attr_reader :attributes
    def initialize
      @attributes = {}
      yield(self) if block_given?
    end

    def append(container, key, value)
      composite_key = "#{container}.#{key}"
      @attributes[composite_key] ||= []
      @attributes[composite_key] << value
    end

    def contexts
      attributes.keys.collect { |key| key.split('.')[0] }.uniq
    end

  end
end