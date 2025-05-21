require 'rails_helper'

RSpec.describe Reward, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'requires name' do
      reward = build(:reward, user: user, name: nil)
      expect(reward).not_to be_valid
      expect(reward.errors[:name]).to include("can't be blank")
    end

    it 'requires issued_at' do
      reward = build(:reward, user: user, issued_at: nil)
      expect(reward).not_to be_valid
      expect(reward.errors[:issued_at]).to include("can't be blank")
    end
  end

  describe 'reward types' do
    before do
      create(:reward, :coffee, user: user)
      create(:reward, :movie_tickets, user: user)
    end

    it 'can filter by coffee type using where' do
      expect(user.rewards.where(name: 'Free Coffee').count).to eq(1)
    end

    it 'can filter by movie tickets type using where' do
      expect(user.rewards.where(name: 'Free Movie Tickets').count).to eq(1)
    end
  end
end
