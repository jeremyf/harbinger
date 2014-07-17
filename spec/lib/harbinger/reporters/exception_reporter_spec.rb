require 'spec_fast_helper'
require 'harbinger/reporters/exception_reporter'

module Harbinger::Reporters
  describe ExceptionReporter do

    it_should_behave_like "a harbinger reporter"

    context 'specific behavior' do

      Given(:message) { double('Message', append: true) }
      Given(:exception_message) { 'exception message' }
      Given(:exception) { RuntimeError.new(exception_message) }
      Given(:reporter) { described_class.new(exception) }

      When { reporter.accept(message) }

      Then { expect(message).to have_received(:append).with('exception', 'class_name', exception.class.to_s) }
      And { expect(message).to have_received(:append).with('exception', 'backtrace', [].join("\n")) }
      And { expect(message).to have_received(:append).with('exception', 'message', exception.message) }

    end
  end
end
