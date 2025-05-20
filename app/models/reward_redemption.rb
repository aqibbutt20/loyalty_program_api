class RewardRedemption < ApplicationRecord
  belongs_to :user
  belongs_to :reward

  validates :points_spent, numericality: { greater_than: 0 }
  validates :redeemed_at, presence: true
end
