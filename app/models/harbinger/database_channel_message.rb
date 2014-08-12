require 'active_record'
require 'harbinger/database_channel_message_element'

module Harbinger
  class DatabaseChannelMessage < ActiveRecord::Base
    self.table_name = 'harbinger_messages'
    has_many :elements, class_name: 'Harbinger::DatabaseChannelMessageElement', foreign_key: :message_id

    def contexts=(values)
      super(Array.wrap(values).join(','))
    end

    def contexts
      super.split(',')
    end

    def self.store_message(message, storage = new)
      storage.contexts = message.contexts
      storage.state = 'new'
      message.attributes.each do |key, value|
        storage.elements.build(key: key, value: value)
      end
      storage.save!
    end

    def self.search(params = {})
      all
    end
  end
end
