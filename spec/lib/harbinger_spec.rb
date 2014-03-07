require 'fast_helper'
require 'harbinger'

describe Harbinger do
  Given(:user) { User.new(username: 'a username') }
  Given(:request) { Request.new(path: '/path/to/awesome', params: {hello: :world}, user_agent: "Ruby") }

  context '.call' do
    Given(:message) { Harbinger::Message.new }
    When { Harbinger.call(contexts: [user, request], message: message) }
    Then { expect(message.attributes).to eq(
             {
               'user.username' => [user.username],
               'request.path' => [request.path],
               'request.params' => [request.params],
               'request.user_agent' => [request.user_agent],
             }
           )
           }
  end

  context '.deliver' do
    Given(:message) { Harbinger::Message.new }
    Given(:channel) { double('Channel', deliver: true) }
    When { Harbinger.deliver(message, channels: channel) }
    Then { expect(channel).to have_received(:deliver).with(message) }
  end

  context '.logger' do
    Given(:logger) { Harbinger.logger }
    Then { expect(logger).to respond_to :add }
  end
end