require 'fast_helper'
require 'harbinger/message'

module Harbinger
  describe Message do
    Given(:message) { described_class.new }
    When { message.append('container', 'key', 'value')}
    When { message.append('other_container', 'other_key', 'other_value')}
    Then { expect(message.attributes).to eq({ 'container.key' => ['value'], 'other_container.other_key' => ['other_value']}) }
  end
end
