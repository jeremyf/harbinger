require 'rspec/given'
Dir[File.expand_path("../../app/*", __FILE__)].each do |dir|
  $LOAD_PATH << dir
end
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

class AttributeBucket
  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end
end

class Request < AttributeBucket
  attr_accessor :path, :params, :user_agent
end

unless defined?(User)
  class User < AttributeBucket
    attr_accessor :username
  end
end

shared_examples 'a harbinger reporter' do
  Given(:reporter) { described_class.new(double) }
  Then { expect(reporter).to respond_to(:accept) }
  And { expect(reporter.method(:accept).arity).to eq(1) }
end


shared_examples "a harbinger channel" do
  Given(:channel) { described_class }
  Then { expect(channel).to respond_to(:deliver) }
  And { expect(channel.method(:deliver).arity).to eq(-2) }
end