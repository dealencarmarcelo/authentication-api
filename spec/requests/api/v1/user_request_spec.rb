require 'rails_helper'
require 'shoulda/matchers'

describe 'User', type: :request do
    
    describe 'get users' do
        before { get api_v1_users_path }

        it 'returns status 200' do
            expect(response).to have_http_status(200)
        end
    end
end