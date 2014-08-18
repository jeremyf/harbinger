require 'spec_fast_helper'
require 'harbinger/message'

module Harbinger
  describe Message do
    Given(:message) { described_class.new }

    When { message.append('container', 'key', 'value')}
    When { message.append('other_container', 'other_key', 'other_value')}

    Then { expect(message.attributes).to eq({ 'container.key' => ['value'], 'other_container.other_key' => ['other_value']}) }
    And { expect(message.reporters).to eq(['container', 'other_container']) }

  end
end
