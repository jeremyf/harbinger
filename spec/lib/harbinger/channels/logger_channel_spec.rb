require 'fast_helper'
require 'harbinger/channels/logger_channel'

module Harbinger::Channels
  describe LoggerChannel do

    context '.deliver' do
      Given(:logger_channel) { described_class }
      Given(:logger) { double('Logger', add: true ) }
      Given(:severity) { double('Severity') }
      Given(:message) { double("Message", to_s: 'to_s') }
      When { logger_channel.deliver(message, logger: logger, severity: severity) }
      Then { logger.should have_received(:add).with(severity, message.to_s) }
    end

  end
end
