require 'rails_helper'

RSpec.describe RewardIssuanceService do
  let(:user) { create(:user) }

  describe '#call' do
    context 'when user qualifies for monthly coffee' do
      before do
        create_list(:transaction, 3, user: user, amount: 500, occurred_at: Time.current)
      end

      it 'issues free coffee reward' do
        expect { described_class.new(user).call }.to change { user.rewards.where(name: 'Free Coffee').count }.by(1)
      end
    end

    context 'during birthday month' do
      let(:user) { create(:user, :birthday_month) }

      it 'issues free coffee reward' do
        expect { described_class.new(user).call }.to change { user.rewards.where(name: 'Free Coffee').count }.by(1)
      end
    end

    context 'when new user spends > $1000 in 60 days' do
      let(:user) { create(:user, :new_user) }

      before do
        create(:transaction, user: user, amount: 1001, occurred_at: Time.current - 10.days)
      end

      it 'issues movie tickets reward' do
        expect { described_class.new(user).call }.to change { user.rewards.where(name: 'Free Movie Tickets').count }.by(1)
      end
    end

    context 'when no conditions are met' do
      it 'does not issue any rewards' do
        expect { described_class.new(user).call }.not_to change { user.rewards.count }
      end
    end
  end
end
