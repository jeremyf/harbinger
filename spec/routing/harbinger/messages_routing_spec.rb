require 'spec_slow_helper'

module Harbinger
  describe 'routes for Messages', type: :routing do
    routes { Harbinger::Engine.routes }

    it 'generates a resourceful URL for :index' do
      expect(messages_path).to eq('/harbinger/messages')
    end

    it 'generates a resourceful URL for :show' do
      expect(message_path('1')).to eq('/harbinger/messages/1')
    end

    it 'should route actions based on namespace' do
      expect(
        url_for(
          { action: "index", controller: "harbinger/messages", page: nil, only_path: true }
        )
      ).to eq('/harbinger/messages')
    end

  end
end
