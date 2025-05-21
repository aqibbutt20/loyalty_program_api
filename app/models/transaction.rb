class Transaction < ApplicationRecord
  belongs_to :user

  after_create :issue_rewards_if_eligible

  validates :amount, :country, :occurred_at, presence: true
  validates :amount, numericality: { greater_than: 0 }

  def earned_points
    PointsEarningService.new(self).call
  end

  private

  def issue_rewards_if_eligible
    RewardIssuanceService.new(user).call
  end
end
