require 'spec_active_record_helper'
require 'harbinger/database_channel_message_element'

module Harbinger
  describe DatabaseChannelMessageElement do
    context '.search_text' do
      it 'handles a query parameter' do
        expect(described_class.search_text('Hello').to_sql).to be_a(String)
      end

      it 'wild card searches the value' do
        expect(described_class.search_text('Hello').to_sql).to match(/%Hello%/)
      end
    end
  end
end
