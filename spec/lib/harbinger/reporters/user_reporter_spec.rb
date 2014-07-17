require 'spec_fast_helper'
require 'harbinger/reporters/user_reporter'

module Harbinger::Reporters
  describe UserReporter do

    it_should_behave_like "a harbinger reporter"

    context 'specific behavior' do
      Given(:user) { double('User', username: 'a username' ) }
      Given(:message) { double('Message', append: true) }
      Given(:reporter) { described_class.new(user) }
      When { reporter.accept(message) }
      Then { expect(message).to have_received(:append).with('user', 'username', user.username) }
    end
  end
end
