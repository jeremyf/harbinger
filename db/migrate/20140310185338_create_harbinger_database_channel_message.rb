class CreateHarbingerDatabaseChannelMessage < ActiveRecord::Migration
  def change
    create_table :harbinger_messages do |t|
      t.string :contexts
      t.string :state, limit: 32
      t.timestamps
    end
    add_index :harbinger_messages, :state
    add_index :harbinger_messages, :contexts
  end
end
