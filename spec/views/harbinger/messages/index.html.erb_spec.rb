require 'spec_view_helper'

# As of 3.0.x :type tags are no longer inferred.
# This means, without the `type: :view` tag, the render method does not exist
# in the example context
describe 'harbinger/messages/index.html.erb', type: :view do
  let(:created_at) { Time.now }
  let(:message) do
    double(
      'Message',
      contexts: ['Hello','World'],
      state: 'new',
      created_at: created_at
    )
  end
  let(:harbinger) { double("Engine", message_path: true) }
  it 'renders the object and fieldsets' do
    expect(harbinger).to receive(:message_path).with(message.to_param).and_return("/path/to/message")
    render template: "harbinger/messages/index.html.erb", locals: { messages: [message], harbinger: harbinger }
    expect(rendered).to have_tag('.message') do
      with_tag(".detail.message-created-at-detail a time", text: created_at.to_s)
      with_tag('.detail.message-contexts-detail', text: 'Hello')
      with_tag('.detail.message-contexts-detail', text: 'World')
      with_tag('.detail.message-state-detail', text: 'new')
    end
  end
end
