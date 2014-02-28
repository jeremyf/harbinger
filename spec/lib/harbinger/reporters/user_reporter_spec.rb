require 'fast_helper'
require 'harbinger/reporters/user_reporter'

module Harbinger::Reporters
  describe UserReporter do
    Given(:message) { double('Message', append: true) }
    Given(:user) { double('User', username: 'a username' ) }
    Given(:reporter) { described_class.new(user) }

    When { reporter.accept(message) }

    Then { message.should have_received(:append).with('user', 'username', user.username) }

  end
end
