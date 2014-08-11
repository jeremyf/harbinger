require 'spec_slow_helper'
require 'harbinger'

module Harbinger
  describe 'handling a message', type: :feature do
    let(:message) do
      begin
        {}.fetch(:missing_key)
      rescue KeyError => exception
        Harbinger.call(contexts: [exception])
      end
    end

    it 'sends the exception message to the database channel' do
      expect { Harbinger.deliver(message, channels: :database) }.
      to change { DatabaseChannelMessage.count }.
      by(1)

      visit 'harbinger/messages'

    end
  end
end