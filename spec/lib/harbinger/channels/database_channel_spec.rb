require 'fast_helper'
require 'harbinger/channels/database_channel'

module Harbinger::Channels
  describe DatabaseChannel do

    it_should_behave_like "a harbinger channel"

    context '.deliver' do
      Given(:database_channel) { described_class }
      Given(:storage) { double('Database', store_message: true ) }
      Given(:message) { double("Message") }
      When { database_channel.deliver(message, storage: storage) }
      Then { storage.should have_received(:store_message).with(message) }
    end

  end
end
