require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe '#earned_points' do
    let(:user) { create(:user) }

    context 'with domestic transaction' do
      it 'calculates 10 points per $100' do
        transaction = create(:transaction, user: user, amount: 150, country: 'US')
        expect(transaction.earned_points).to eq(15)
      end
    end

    context 'with foreign transaction' do
      it 'calculates 2x points' do
        transaction = create(:transaction, user: user, amount: 150, country: 'JP')
        expect(transaction.earned_points).to eq(30)
      end
    end

    context 'with small amount' do
      it 'rounds points correctly' do
        transaction = create(:transaction, user: user, amount: 99, country: 'US')
        expect(transaction.earned_points).to eq(10)
      end
    end
  end
end
