require 'rails_helper'
require 'webmock/rspec'

RSpec.describe AutomationsController, type: :controller do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
    allow_any_instance_of(AutomationsController).to receive(:authenticate_user).and_return(true)
    allow_any_instance_of(AutomationsController).to receive(:current_user).and_return(User.new(email: 'test@example.com'))
  end

  describe 'POST #request_link' do
    it 'requests automation link successfully' do
      stub_request(:post, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })
      
      post :request_link, params: { email: 'test@example.com', otp_token: 'otp_token' }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #send_linkedin_message' do
    it 'sends LinkedIn message successfully' do
      stub_request(:post, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })
      stub_request(:get, /api6.unipile.com/).to_return(status: 200, body: '{"data": [{"attendee_provider_id":"1"}]}', headers: { 'Content-Type' => 'application/json' })
      
      post :send_linkedin_message, params: { account_id: 'account_id', text: 'message', attendees_ids: ['1'] }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #list_attendees' do
    it 'lists attendees successfully' do
      stub_request(:get, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })
      
      get :list_attendees, params: { account_id: 'account_id' }
      expect(response).to have_http_status(:ok)
    end

    it 'returns unprocessable entity for missing account_id' do
      get :list_attendees
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #list_chats' do
    it 'lists chats successfully' do
      stub_request(:get, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })
      
      get :list_chats, params: { account_id: 'account_id' }
      expect(response).to have_http_status(:ok)
    end

    it 'returns unprocessable entity for missing account_id' do
      get :list_chats
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST #send_email' do
    it 'sends email successfully' do
      stub_request(:post, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })
      
      post :send_email, params: { 
        account_id: 'account_id', 
        from: { display_name: 'Sender', identifier: 'sender@example.com' }, 
        to: [{ display_name: 'Receiver', identifier: 'receiver@example.com' }], 
        subject: 'subject', 
        body: 'body' 
      }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #send_message' do
    it 'sends chat message successfully' do
      stub_request(:post, /api6.unipile.com/).to_return(status: 200, body: '{"success": true}', headers: { 'Content-Type' => 'application/json' })
      
      post :send_message, params: { chat_id: 'chat_id', text: 'message' }
      expect(response).to have_http_status(:ok)
    end
  end
end