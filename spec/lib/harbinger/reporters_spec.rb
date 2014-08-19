require 'spec_fast_helper'
require 'harbinger/reporters'

module Harbinger
  class Request
  end
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

      context 'implicit conversion of an exception' do
        Given(:context) do
          begin
            {}.fetch(:missing_key)
          rescue KeyError => exception
            exception
          end
        end
        When(:result) { described_class.find_for(context) }
        Then { expect(result).to be_an_instance_of(Reporters::ExceptionReporter) }
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

      context 'module conversion' do
        Given(:context) { ::Harbinger::Request.new }
        When(:result) { described_class.find_for(context) }
        Then { expect(result).to be_an_instance_of(Reporters::RequestReporter) }
      end
    end
  end
end
