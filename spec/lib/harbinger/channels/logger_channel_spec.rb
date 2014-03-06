require 'fast_helper'
require 'harbinger/channels/logger_channel'

module Harbinger::Channels
  describe LoggerChannel do

    context '.deliver' do
      Given(:logger_channel) { described_class }
      Given(:logger) { double('Logger', add: true ) }
      Given(:severity) { double('Severity') }
      Given(:message) { double("Message", attributes: {to_s: 'Hello'}) }
      When { logger_channel.deliver(message, logger: logger, severity: severity) }
      Then { logger.should have_received(:add).with(severity, %(BEGIN MESSAGE OBJECT ID=#{message.object_id})) }
      And { logger.should have_received(:add).with(severity, %(:to_s => \"Hello\")) }
      And { logger.should have_received(:add).with(severity, %(END MESSAGE OBJECT ID=#{message.object_id})) }
    end

  end
end
