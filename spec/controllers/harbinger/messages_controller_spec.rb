require 'spec_slow_helper'
require 'harbinger/messages_controller'

module Harbinger
  describe MessagesController, type: :controller do
    routes { Harbinger::Engine.routes }
    render_views false
    context 'GET :index' do
      it 'searches the DatabaseChannelMessage' do
        message_1, message_2 = double, double
        allow(DatabaseChannelMessage).to receive(:search) { [message_1, message_2] }
        get :index
        expect(assigns(:messages)).to eq([message_1, message_2])
      end
    end

    context 'GET :show' do
      it 'retrieves the DatabaseChannelMessage' do
        message = double
        allow(DatabaseChannelMessage).to receive(:find).with('1') { message }
        get :show, id: '1'
        expect(assigns(:message)).to eq(message)
      end
    end
  end
end
