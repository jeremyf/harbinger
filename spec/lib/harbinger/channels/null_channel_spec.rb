require 'spec_fast_helper'
require 'harbinger/channels/null_channel'

module Harbinger::Channels
  describe NullChannel do
    it_should_behave_like "a harbinger channel"
  end
end