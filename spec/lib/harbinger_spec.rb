require 'fast_helper'
require 'harbinger'

describe Harbinger do
  Given(:user) { User.new.tap {|u| u.username = 'a username'} }
  context '.reporter_for' do
    When(:reporter) { Harbinger.reporter_for(user) }
    Then { expect(reporter).to be_an_instance_of(Harbinger::Reporters::UserReporter) }
  end

  context '.call' do
    Given(:message) { Harbinger::Message.new }
    When { Harbinger.call(contexts: user, message: message) }
    Then { expect(message.attributes).to eq({'user.username' => [user.username] }) }
  end
end
