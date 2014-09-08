require 'spec_fast_helper'
require 'harbinger'
require 'harbinger/message'

describe Harbinger do
  Given(:user) { User.new(username: 'a username') }
  Given(:request) { Request.new(path: '/path/to/awesome', params: { hello: :world }, user_agent: "Ruby") }

  context '.call' do
    before(:each) do
      expect(Harbinger::Channels).to receive(:find_for).with(channel_name).and_return(channel)
    end
    Given(:channel_name) { 'channel_double' }
    Given(:channel_name) { 'channel_double' }
    Given(:channel) { double('Channel', deliver: true) }
    Given(:message) { Harbinger::Message.new }
    When { Harbinger.call(reporters: [user, request], message: message, channels: channel_name) }
    Then do expect(message.attributes).to eq(
        'user.username' => [user.username],
        'request.path' => [request.path],
        'request.user_agent' => [request.user_agent]
      )
    end
    And { expect(channel).to have_received(:deliver).with(message) }
  end

  context '.build_message' do
    Given(:message) { Harbinger::Message.new }
    When { Harbinger.build_message(reporters: [user, request], message: message) }
    Then do expect(message.attributes).to eq(
        'user.username' => [user.username],
        'request.path' => [request.path],
        'request.user_agent' => [request.user_agent]
      )
    end
  end

  context '.deliver_message' do
    before(:each) do
      expect(Harbinger::Channels).to receive(:find_for).with(channel_name).and_return(channel)
    end
    Given(:message) { Harbinger::Message.new }
    Given(:channel_name) { 'channel_double' }
    Given(:channel) { double('Channel', deliver: true) }
    When { Harbinger.deliver_message(message, channels: channel_name) }
    Then { expect(channel).to have_received(:deliver).with(message) }
  end

  context '.logger' do
    Given(:logger) { Harbinger.logger }
    Then { expect(logger).to respond_to :add }
  end

  context '.database_storage' do
    Given(:database_storage) { Harbinger.database_storage }
    Then { expect(database_storage).to respond_to :store_message }
  end
end
