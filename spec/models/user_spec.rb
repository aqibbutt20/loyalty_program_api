require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#birthday_month?' do
    let(:user) { create(:user, birthday: Date.new(1990, Date.current.month, 15)) }

    it 'returns true when birthday is current month' do
      expect(user.birthday_month?).to be true
    end

    it 'returns false when birthday is different month' do
      user.birthday = Date.new(1990, Date.current.next_month.month, 15)
      expect(user.birthday_month?).to be false
    end
  end

  describe '#total_points_in_month' do
    let(:user) { create(:user) }

    before do
      create(:transaction, user: user, amount: 150, country: 'US', occurred_at: Date.current.beginning_of_month)
      create(:transaction, user: user, amount: 200, country: 'US', occurred_at: Date.current.end_of_month)
      create(:transaction, user: user, amount: 100, country: 'US', occurred_at: 3.months.ago)
    end

    it 'sums points only for current month' do
      expect(user.total_points_in_month).to eq(35)
    end
  end
end
