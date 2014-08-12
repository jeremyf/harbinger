require 'spec_active_record_helper'
require 'harbinger/database_channel_message'
require 'harbinger/message'

module Harbinger
  describe DatabaseChannelMessage do
    subject { described_class.new }
    let(:message) do
      Message.new do |message|
        message.append('exception', 'name', 'hello')
        message.append('exception', 'name', 'world')
        message.append('user', 'name', 'tim')
        message.append('user', 'id', '123')
      end
    end

    it 'should have many elements' do
      subject.save!
      expect(subject.elements).to be_a_kind_of(ActiveRecord::Associations::CollectionProxy)
    end

    context '.search' do
      xit 'is paginated'
      xit 'handles a query parameter'
    end

    context '.store_message' do
      it 'creates a new instance' do
        expect { described_class.store_message(message) }.
          to change { described_class.count }.
          by(1)
      end

      it 'creates elements' do
        storage = described_class.new
        expect { described_class.store_message(message, storage) }.
          to change { storage.elements.count }.
          by(3)
      end

      it 'assigns :contexts' do
        storage = described_class.new
        expect { described_class.store_message(message, storage) }.
          to change { storage.attributes.values_at('contexts', 'state') }.
          from([nil, nil]).to(['exception,user', 'new'])
      end
    end
  end
end
