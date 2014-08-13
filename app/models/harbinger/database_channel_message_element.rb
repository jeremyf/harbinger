require 'active_record'
require 'harbinger/database_channel_message'

module Harbinger
  class DatabaseChannelMessageElement < ActiveRecord::Base
    self.table_name = 'harbinger_message_elements'
    belongs_to :message, class_name: 'Harbinger::DatabaseChannelMessage', foreign_key: :message_id
    serialize :value

    scope :search_text, ->(text) {
      if text
        where(arel_table[:value].matches("#{text}*"))
      else
        self
      end
    }
  end
end