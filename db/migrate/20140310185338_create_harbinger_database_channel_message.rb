class CreateHarbingerDatabaseChannelMessage < ActiveRecord::Migration
  def change
    create_table :harbinger_messages do |t|
      t.string :reporters
      t.string :state, limit: 32
      t.integer :message_object_id
      t.timestamps
    end
    add_index :harbinger_messages, :state
    add_index :harbinger_messages, :reporters
    add_index :harbinger_messages, :message_object_id
  end
end
