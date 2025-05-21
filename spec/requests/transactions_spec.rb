require 'rails_helper'

RSpec.describe 'Transactions API', type: :request do
  let(:user) { create(:user) }
  let(:valid_headers) { { 'X-API-Key' => Rails.application.credentials.client_api_key } }

  describe 'POST /users/:user_id/transactions' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          transaction: {
            amount: 150,
            country: 'JP',
            occurred_at: Time.current
          }
        }
      end

      it 'creates a transaction' do
        expect {
          post "/users/#{user.id}/transactions",
               params: valid_params,
               headers: valid_headers
        }.to change(Transaction, :count).by(1)
      end

      it 'returns correct points calculation' do
        post "/users/#{user.id}/transactions",
             params: valid_params,
             headers: valid_headers
        expect(JSON.parse(response.body)['earned_points']).to eq(30)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        post "/users/#{user.id}/transactions",
             params: { transaction: { amount: nil } },
             headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
