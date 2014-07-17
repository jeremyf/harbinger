require 'active_record'

module Harbinger
  class DatabaseChannelMessage < ActiveRecord::Base
    self.table_name = 'harbinger_messages'
    has_many :elements, class_name: 'Harbinger::DatabaseChannelMessageElement', foreign_key: :message_id

    def self.store_message(message)
    end
  end
end