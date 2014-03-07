require 'fast_helper'
require 'harbinger/reporters/request_reporter'

module Harbinger::Reporters
  describe RequestReporter do

    it_should_behave_like "a harbinger reporter"

    context 'specific behavior' do

      Given(:request) { double('Request', path: '/path/to/url', params: { id: 'id', contorller: 'controller'}, user_agent: 'user_agent' ) }
      Given(:reporter) { described_class.new(request) }
      Given(:message) { double('Message', append: true) }


      When { reporter.accept(message) }
      Then { message.should have_received(:append).with('request', 'path', request.path) }
      And { message.should have_received(:append).with('request', 'params', request.params) }
      And { message.should have_received(:append).with('request', 'user_agent', request.user_agent) }

    end
  end
end
