require 'fast_helper'
require 'harbinger/reporters/null_reporter'

module Harbinger::Reporters
  describe NullReporter do

    it_should_behave_like "a harbinger reporter"

    context 'specific behavior' do

      Given(:message) { double('Message', append: true) }
      Given(:context) { double('Request') }
      Given(:reporter) { described_class.new(context) }

      When { reporter.accept(message) }

      Then { message.should have_received(:append).with('nil', context.class.to_s, context.inspect) }

    end
  end
end
