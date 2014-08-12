require 'spec_fast_helper'
require 'harbinger/configuration'
require 'logger'

module Harbinger
  describe Configuration do
    Given(:configuration) { described_class.new }

    context '#default_channels' do
      When { configuration.default_channels = [:logger, 'Database'] }
      Then { expect(configuration.default_channels).to eq([:logger, :database]) }
    end

    context '#default_channels without assignment' do
      When(:default_channels) { configuration.default_channels }
      Then { expect(default_channels).to eq([:logger]) }
    end

    context '#logger' do
      context 'interface' do
        Then { expect(configuration.logger).to respond_to :add }
      end

      context 'override with valid logger' do
        Given(:logger) { double('Logger', add: true) }
        When { configuration.logger = logger }
        Then { expect(configuration.logger).to eq(logger) }
      end

      context 'default logger without rails' do
        Given { Object.send(:remove_const, :Rails) if defined?(Rails) }
        When(:default_logger) { configuration.logger }
        Then { expect(default_logger).to be_an_instance_of(Logger) }
        And { expect(defined?(Rails)).to be_falsey }
      end

      context 'override without valid logger' do
        Given(:logger) { double('Logger') }
        Then { expect { configuration.logger = logger }.to raise_error(ConfigurationError) }
      end
    end

    context '#database_storage' do
      context 'interface' do
        Then { expect(configuration.database_storage).to respond_to :store_message }
      end

      context 'override with valid database_storage' do
        Given(:database_storage) { double('Database Storage', store_message: true) }
        When { configuration.database_storage = database_storage }
        Then { expect(configuration.database_storage).to eq(database_storage) }
      end

      context 'override without valid database_storage' do
        Given(:database_storage) { double('Database Storage') }
        Then { expect { configuration.database_storage = database_storage }.to raise_error(ConfigurationError) }
      end
    end
  end
end
