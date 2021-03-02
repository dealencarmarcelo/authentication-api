require 'rails_helper'

describe Api::V1::AuthenticationController do
  describe 'POST /auth/login' do
    
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }

    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end

    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    context 'When request is valid' do
      before { post login_api_v1_authentication_index_path, params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        response_body = JSON.parse(response.body)

        expect(response_body.fetch('auth_token')).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before { post login_api_v1_authentication_index_path, params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        response_body = JSON.parse(response.body)

        expect(response_body.fetch('message')).to match(/Invalid credentials/)
      end
    end
  end
end