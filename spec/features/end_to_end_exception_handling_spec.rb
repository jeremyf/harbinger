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
      expect(Harbinger.logger).to receive(:add).at_least(:once).and_call_original

      expect { Harbinger.deliver(message, channels: [:database, :logger]) }.
        to change { DatabaseChannelMessage.count }.
        by(1)

      message = DatabaseChannelMessage.last

      visit 'harbinger/messages'

      # Search page
      page.within('.search-form') do
        page.fill_in('Search Text', with: 'KeyError')
        page.click_button('Search')
      end

      page.find(:xpath, "//a[@href='#{harbinger.message_path(message.to_param)}']").click

      expect(page.html).to have_tag('.message') do
        with_tag('.message-contexts-detail', text: 'exception')
        with_tag('.message-state-detail', text: 'new')
      end
    end
  end
end
