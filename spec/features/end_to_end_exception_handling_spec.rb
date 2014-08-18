require 'spec_slow_helper'
require 'harbinger'

module Harbinger
  describe 'handling a message', type: :feature do
    let(:message) do
    end

    it 'sends the exception message to the database channel' do
      expect(Harbinger.logger).to receive(:add).at_least(:once).and_call_original
      begin
        {}.fetch(:missing_key)
      rescue KeyError => exception
        Harbinger.call(channels: [:database, :logger], reporters: [exception])
      end

      message = DatabaseChannelMessage.last

      visit 'harbinger/messages'

      # Search page
      page.within('.search-form') do
        page.fill_in('Search Text', with: 'KeyError')
        page.click_button('Search')
      end

      page.find(:xpath, "//a[@href='#{harbinger.message_path(message.to_param)}']").click

      expect(page.html).to have_tag('.message') do
        with_tag('.message-reporters-detail', text: 'exception')
        with_tag('.message-state-detail', text: 'new')
      end
    end
  end
end
