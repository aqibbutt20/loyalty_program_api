require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:valid_headers) { { 'X-API-Key' => Rails.application.credentials.client_api_key } }
  let(:valid_attributes) do
    {
      user: {
        name: 'John Doe',
        email: 'john@example.com',
        birthday: '1990-01-01'
      }
    }
  end

  describe 'POST /users' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post '/users', 
               params: valid_attributes, 
               headers: valid_headers,
               as: :json
        }.to change(User, :count).by(1)
      end

      it 'returns a 201 status code' do
        post '/users', params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
      end

      it 'returns the created user' do
        post '/users', params: valid_attributes, headers: valid_headers, as: :json
        expect(JSON.parse(response.body)['email']).to eq('john@example.com')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a user with missing email' do
        post '/users', 
             params: { user: valid_attributes[:user].except(:email) }, 
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns validation errors' do
        post '/users', 
             params: { user: valid_attributes[:user].except(:name) }, 
             headers: valid_headers,
             as: :json
        expect(JSON.parse(response.body)['errors']).to include("Name can't be blank")
      end

      it 'rejects duplicate emails' do
        create(:user, email: 'john@example.com')
        post '/users', params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
