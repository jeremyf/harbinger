require 'fast_helper'
require 'harbinger'

describe Harbinger do
  context '.reporter_for' do
    Given(:user) { User.new.tap {|u| u.username = 'a username'} }
    When(:reporter) { Harbinger.reporter_for(user) }
    Then { expect(reporter).to be_an_instance_of(Harbinger::Reporters::UserReporter) }
  end
end
