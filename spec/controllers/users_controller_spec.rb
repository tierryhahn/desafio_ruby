require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) { { name: 'John Doe', email: Faker::Internet.unique.email, password: 'password', password_confirmation: 'password' } }

    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
        
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        invalid_attributes = valid_attributes.merge(email: 'invalid-email')
        
        post :create, params: { user: invalid_attributes }
        
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #sign_in_with_otp' do
    let(:unique_email) { Faker::Internet.unique.email }
    let!(:user) { FactoryBot.create(:user, email: unique_email) }

    it 'signs in user with valid OTP' do
      otp_token = user.generate_otp_token

      post :sign_in_with_otp, params: { email: user.email, otp_token: otp_token }
      expect(response).to have_http_status(:ok)
    end

    it 'returns unauthorized status for invalid OTP' do
      invalid_otp_token = 'invalid-otp'

      post :sign_in_with_otp, params: { email: user.email, otp_token: invalid_otp_token }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns unauthorized status for invalid email' do
      post :sign_in_with_otp, params: { email: 'wrong@example.com', otp_token: '123456' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'PATCH #update_account_ids' do
    let(:unique_email) { Faker::Internet.unique.email }
    let!(:user) { FactoryBot.create(:user, email: unique_email, unipile_email_account_id: 'old_id', unipile_linkedin_account_id: 'old_id') }

    it 'updates account ids successfully' do
      patch :update_account_ids, params: { email: user.email, unipile_email_account_id: 'new_id', unipile_linkedin_account_id: 'new_id' }
      user.reload
      expect(user.unipile_email_account_id).to eq('new_id')
      expect(user.unipile_linkedin_account_id).to eq('new_id')
      expect(response).to have_http_status(:ok)
    end

    it 'returns not found status for invalid email' do
      patch :update_account_ids, params: { email: 'wrong@example.com', unipile_email_account_id: 'new_id', unipile_linkedin_account_id: 'new_id' }
      expect(response).to have_http_status(:not_found)
    end
  end
end