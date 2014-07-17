module Harbinger
  class DatabaseChannelMessageElement < ActiveRecord::Base
    self.table_name = 'harbinger_message_elements'
    belongs_to :message, class_name: 'Harbinger::DatabaseChannelMessage', foreign_key: :message_id
    serialize :value
  end
end