require 'fast_helper'
require 'harbinger/configuration'

module Harbinger
  describe Configuration do
    context '#logger' do
      context 'interface' do
        Given(:configuration) { described_class.new }
        Then { expect(configuration.logger).to respond_to :add }
      end

      context 'override with valid logger' do
        Given(:logger) { double('Logger', add: true) }
        Given(:configuration) { described_class.new(logger: logger) }
        Then { expect(configuration.logger).to eq(logger) }
      end

      context 'override without valid logger' do
        Given(:logger) { double('Logger') }
        Then { expect { described_class.new(logger: logger) }.to raise_error(ConfigurationError) }
      end
    end
  end
end
