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

unless defined?(User)
  class AttributeBucket
    def initialize(attributes = {})
      attributes.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
  end

  class User < AttributeBucket
    attr_accessor :username
  end

  class Request < AttributeBucket
    attr_accessor :path, :params, :user_agent
  end
end
