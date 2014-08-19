require 'spec_view_helper'

# As of 3.0.x :type tags are no longer inferred.
# This means, without the `type: :view` tag, the render method does not exist
# in the example context
describe 'harbinger/messages/show.html.erb', type: :view do
  let(:created_at) { Time.now }
  let(:netid_element) { double('Element', key: 'netid', value: 'jfriesen') }
  let(:request_referrer_element) { double('Element', key: 'request_referrer', value: 'from somewhere') }
  let(:message) do
    double(
      'Message',
      reporters: ['Hello','World'],
      state: 'new',
      created_at: created_at,
      message_object_id: '123456',
      elements: [netid_element, request_referrer_element]
    )
  end
  it 'renders the object and fieldsets' do
    render template: 'harbinger/messages/show',
      locals: { message: message }
    expect(rendered).to have_tag('article.message') do
      with_tag('.term.message-reporters-term')
      with_tag('.detail.message-reporters-detail', text: 'Hello')
      with_tag('.detail.message-reporters-detail', text: 'World')
      with_tag('.term.message-object-id-term')
      with_tag('.detail.message-object-id-detail', text: '123456')
      with_tag('.term.message-state-term')
      with_tag('.detail.message-state-detail', text: 'new')
      with_tag('.term.message-created-at-term')
      with_tag('.detail.message-created-at-detail time', text: created_at.to_s)
      with_tag('.term.netid-term', text: netid_element.key)
      with_tag('.detail.netid-detail', text: netid_element.value)
      with_tag('.term.request-referrer-term', text: request_referrer_element.key)
      with_tag('.detail.request-referrer-detail', text: request_referrer_element.value)
    end
  end
end
