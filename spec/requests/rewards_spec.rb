require 'rails_helper'

RSpec.describe 'Rewards API', type: :request do
  let(:user) { create(:user) }
  let(:valid_headers) { { 'X-API-Key' => Rails.application.credentials.client_api_key } }

  describe 'GET /users/:user_id/rewards' do
    before do
      create(:reward, :coffee, user: user)
      create(:reward, :movie_tickets, user: user)
    end

    it 'returns all rewards for user' do
      get "/users/#{user.id}/rewards", headers: valid_headers
      
      expect(response).to have_http_status(:ok)
      rewards = JSON.parse(response.body)
      expect(rewards.count).to eq(2)
    end

    it 'returns rewards in default order' do
      get "/users/#{user.id}/rewards", headers: valid_headers
      
      rewards = JSON.parse(response.body)
      expect(rewards.pluck('name')).to contain_exactly('Free Coffee', 'Free Movie Tickets')
    end

    it 'ignores filter parameters' do
      get "/users/#{user.id}/rewards?type=Free+Coffee", headers: valid_headers
      
      rewards = JSON.parse(response.body)
      expect(rewards.count).to eq(2)
    end
  end

  context 'when user has no rewards' do
    it 'returns empty array' do
      get "/users/#{user.id}/rewards", headers: valid_headers
      
      rewards = JSON.parse(response.body)
      expect(rewards).to be_empty
    end
  end
end
