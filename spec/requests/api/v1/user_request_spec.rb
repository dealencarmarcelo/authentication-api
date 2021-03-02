require 'rails_helper'
require 'shoulda/matchers'

describe 'User', type: :request do

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
    end
end