require 'rails_helper'

RSpec.describe PointsEarningService do
  let(:user) { create(:user) }

  describe '#call' do
    context 'with domestic transaction' do
      let(:transaction) { create(:transaction, :domestic, user: user, amount: 150) }

      it 'calculates standard points' do
        expect(described_class.new(transaction).call).to eq(15)
      end
    end

    context 'with foreign transaction' do
      let(:transaction) { create(:transaction, :foreign, user: user, amount: 150) }

      it 'doubles the points' do
        expect(described_class.new(transaction).call).to eq(30)
      end
    end

    context 'with fractional amounts' do
      it 'rounds points correctly' do
        transaction1 = create(:transaction, user: user, amount: 99.99, country: 'US')
        transaction2 = create(:transaction, user: user, amount: 100.01, country: 'US')
        
        expect(described_class.new(transaction1).call).to eq(10)
        expect(described_class.new(transaction2).call).to eq(10)
      end
    end
  end
end
