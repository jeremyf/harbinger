require 'fast_helper'
require 'harbinger/reporters/request_reporter'

module Harbinger::Reporters
  describe RequestReporter do
    Given(:message) { double('Message', append: true) }
    Given(:request) { double('Request', path: '/path/to/url', params: { id: 'id', contorller: 'controller'}, user_agent: 'user_agent' ) }
    Given(:reporter) { described_class.new(request) }

    When { reporter.accept(message) }

    Then { message.should have_received(:append).with('request', 'path', request.path) }
    And { message.should have_received(:append).with('request', 'params', request.params) }
    And { message.should have_received(:append).with('request', 'user_agent', request.user_agent) }

  end
end
