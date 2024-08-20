require 'rails_helper'
require 'webmock/rspec'

RSpec.describe UnipileService do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
    @unipile_service = UnipileService.new
  end

  describe '#request_automation_link' do
    it 'requests automation link successfully' do
      stub_request(:post, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })
      
      response = @unipile_service.request_automation_link('test@example.com', 'otp_token')
      expect(response['success']).to be_truthy
    end
  end
  
  describe '#start_linkedin_chat' do
    it 'starts linkedin chat successfully' do
      stub_request(:post, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })
      
      response = @unipile_service.start_linkedin_chat('account_id', 'text', ['attendee_id'], 'subject')
      expect(response['success']).to be_truthy
    end
  end

  describe '#send_chat_message' do
    it 'sends chat message successfully' do
      stub_request(:post, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })

      response = @unipile_service.send_chat_message('chat_id', 'message')
      expect(response['success']).to be_truthy
    end
  end

  describe '#send_email' do
    it 'sends email successfully' do
      stub_request(:post, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })

      response = @unipile_service.send_email('account_id', {display_name: 'Sender', identifier: 'sender@example.com'}, [{display_name: 'Recipient', identifier: 'recipient@example.com'}], 'subject', 'body')
      expect(response['success']).to be_truthy
    end
  end

  describe '#list_attendees' do
    it 'lists attendees successfully' do
      stub_request(:get, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })

      response = @unipile_service.list_attendees
      expect(response['success']).to be_truthy
    end
  end

  describe '#list_chats' do
    it 'lists chats successfully' do
      stub_request(:get, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })

      response = @unipile_service.list_chats
      expect(response['success']).to be_truthy
    end
  end
end