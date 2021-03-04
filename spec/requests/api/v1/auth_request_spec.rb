require 'rails_helper'

describe Api::V1::AuthController do

  let!(:user) { create(:user) }
  let(:headers) { valid_headers.except('Authorization') }

  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  let(:valid_credentials) do
    {
      fullname: user.fullname,
      surname: user.surname,
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

  describe 'POST auth login' do
    context 'When request is valid' do
      before { post login_api_v1_auth_index_path, params: valid_credentials, headers: headers }

      it 'returns an auth token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before { post login_api_v1_auth_index_path, params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end

  describe 'POST auth register' do

    let(:headers) { valid_headers.except('Authorization') }

    context 'when valid request' do
      
      before { post register_api_v1_auth_index_path, params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an auth token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post register_api_v1_auth_index_path, params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Fullname can't be blank, Surname can't be blank, Email can't be blank, Email is invalid/)
      end
    end
  end
end