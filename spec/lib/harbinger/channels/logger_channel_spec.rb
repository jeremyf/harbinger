require 'spec_fast_helper'
require 'harbinger/channels/logger_channel'

module Harbinger::Channels
  describe LoggerChannel do

    it_should_behave_like "a harbinger channel"

    context '.deliver' do
      Given(:logger_channel) { described_class }
      Given(:logger) { double('Logger', add: true ) }
      Given(:severity) { double('Severity') }
      Given(:message) { double("Message", attributes: {to_s: 'Hello'}) }
      When { logger_channel.deliver(message, logger: logger, severity: severity) }
      Then { expect(logger).to have_received(:add).with(severity, %(BEGIN MESSAGE OBJECT ID=#{message.object_id})) }
      And { expect(logger).to have_received(:add).with(severity, %(:to_s => \"Hello\")) }
      And { expect(logger).to have_received(:add).with(severity, %(END MESSAGE OBJECT ID=#{message.object_id})) }
    end

  end
end
