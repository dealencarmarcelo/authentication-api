require 'rails_helper'
require 'shoulda/matchers'

describe 'User', type: :request do

    let(:params) do
        {
            user: {
                fullname: Faker::Name.name_with_middle,
                surname: Faker::Name.first_name,
                email: Faker::Internet.email,
                phone: '+5581999999999',
                password: '123456',
                password_confirmation: '123456'
            }
        }
    end

    let(:user) { create(:user) }
    
    describe 'get /users' do
        before { get api_v1_users_path }

        it { expect(response).to have_http_status(:success) }
    end

    describe 'get /users/:id' do
        context 'when user exists' do
            before { get api_v1_user_path(user.id) }

            it { expect(response).to have_http_status(:success) }

            it 'fullname, surmane and email be_kind_of String' do
                response_body = JSON.parse(response.body)

                expect(response_body.fetch('fullname')).to be_kind_of(String)
                expect(response_body.fetch('surname')).to be_kind_of(String)
                expect(response_body.fetch('email')).to be_kind_of(String)
            end
        end

        context 'when user does not exist' do
            it 'raises RecordNotFound when not found' do
                expect { get api_v1_user_path(0) }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end

    describe 'post /users' do
        let(:created_user) { User.last }

        context 'when fullname, surname and email is valid' do
            let(:json) { JSON.parse(response.body, symbolize_names: true) }

            before { post api_v1_users_path, params: params }

            it { expect(response).to have_http_status(:created) }
            it { expect(created_user.fullname).to eq(json.dig(:fullname)) }
        end

        context 'when fullname, surname and email is invalid' do
            it 'returns unprocessable_entity with invalid fullname' do
                post api_v1_users_path, params: { user: { fullname: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid surname' do
                post api_v1_users_path, params: { user: { surname: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns 422 with invalid email' do
                post api_v1_users_path, params: { user: { email: 'email_without_format.com' } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with nil email' do
                post api_v1_users_path, params: { user: { email: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'do not create an user' do
                expect { created_user.name }.to raise_error(NoMethodError)
            end
        end
    end
end