require 'rails_helper'
require 'shoulda/matchers'

describe 'User', type: :request do

    let(:password) { Faker::Alphanumeric.alphanumeric(number: 10) }

    let(:params) do
        {
            user: {
                fullname: Faker::Name.name_with_middle,
                surname: Faker::Name.first_name,
                email: Faker::Internet.email,
                password: password,
                password_confirmation: password
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

    describe 'put /users/:id' do
        context 'when user exists' do
            # let(:password) { Faker::Alphanumeric.alphanumeric(number: 10) }
            let(:small_password) { Faker::Alphanumeric.alphanumeric(number: 5) }

            it 'returns success with valid fullname' do
                put api_v1_user_path(user.id), params: { user: { fullname: Faker::Name.name_with_middle } }
                expect(response).to have_http_status(:success)
            end

            it 'returns success with valid surname' do
                put api_v1_user_path(user.id), params: { user: { surname: Faker::Name.first_name } }
                expect(response).to have_http_status(:success)
            end

            it 'returns success with valid email' do
                put api_v1_user_path(user.id), params: { user: { email: Faker::Internet.email } }
                expect(response).to have_http_status(:success)
            end

            it 'returns success with valid and equals password and password_confirmation' do
                put api_v1_user_path(user.id), params: { user: { password: password, password_confirmation: password } }
                expect(response).to have_http_status(:success)
            end
            
            it 'returns unprocessable_entity with invalid fullname' do
                put api_v1_user_path(user.id), params: { user: { fullname: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid surname' do
                put api_v1_user_path(user.id), params: { user: { surname: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid email' do
                put api_v1_user_path(user.id), params: { user: { email: 'email_without_format.com' } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with nil email' do
                put api_v1_user_path(user.id), params: { user: { email: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with different password and password_confirmation' do
                put api_v1_user_path(user.id), params: { user: { password: password, password_confirmation: '1234567' } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with password and password_confirmation less than 6' do
                put api_v1_user_path(user.id), params: { user: { password: small_password, password_confirmation: small_password } }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context 'when user does not exists' do
            it 'raises RecordNotFound when not found' do
                expect { put api_v1_user_path(User.find(0)), params: params }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end

    describe 'delete /users/:id' do
        context 'when user exists' do
            it 'returns no_content' do
                delete api_v1_user_path(user.id)
                expect(response).to have_http_status(:no_content)
            end
        end
        context 'when user does not exist' do
            it 'raises RecordNotFound when not found' do
                expect { delete api_v1_user_path(User.find(0)) }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end
end