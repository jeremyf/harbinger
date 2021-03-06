require 'spec_fast_helper'
require 'harbinger/channels'

module Harbinger
  module Channels
    class TestChannel
      def self.deliver(message, config = {})
      end
    end
  end

  describe Channels do
    context '.find_for' do

      context 'existing named channel' do
        Given(:channel_name) { :test }
        When(:result) { described_class.find_for(channel_name) }
        Then { expect(result).to eq(Channels::TestChannel) }
        And { expect(result).to respond_to(:deliver) }
      end

      context 'missing named channel' do
        Given(:channel_name) { :four_oh_four }
        When(:result) { described_class.find_for(channel_name) }
        Then { expect(result).to eq(Channels::NullChannel) }
        And { expect(result).to respond_to(:deliver) }
      end

      context 'an exception happened' do
        Given(:channel_name) { :test }
        When(:result) do
          expect(described_class).to receive(:channel_name_for_instance).and_raise(RuntimeError)
          described_class.find_for(channel_name)
        end
        Then { expect(result).to eql(Channels::NullChannel) }
      end

    end
  end
end
