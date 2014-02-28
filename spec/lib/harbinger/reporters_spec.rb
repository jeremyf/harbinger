require 'fast_helper'
require 'harbinger/reporters'

module Harbinger
  describe Reporters do
    context '.find_for' do
      Given(:reporter) { double('Reporter') }

      context 'explicit conversion' do
        Given(:context) { double('User', to_harbinger_reporter: reporter) }
        When(:result) { described_class.find_for(context) }
        Then { expect(result).to eq(reporter) }
      end

      context 'implicit conversion' do
        Given(:context) { User.new }
        When(:result) { described_class.find_for(context) }
        Then { expect(result).to be_an_instance_of(Reporters::UserReporter) }
      end

      context 'constant that raises a name error' do
        Given(:context) { Class.new.new }
        When(:result) { described_class.find_for(context) }
        Then { expect(result).to be_an_instance_of(Reporters::NullReporter) }
      end

      context 'implicit conversion' do
        Given(:context) { Object.new }
        When(:result) { described_class.find_for(context) }
        Then { expect(result).to be_an_instance_of(Reporters::NullReporter) }
      end
    end
  end
end
