class User < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :reward_redemptions, dependent: :destroy

  validates :name, :email, :birthday, presence: true
  validates :email, uniqueness: true

  def total_points_in_month(date)
    transactions
      .where(occurred_at: date.beginning_of_month..date.end_of_month)
      .sum { |t| t.earned_points }
  end

  def total_points_in_year(year)
    transactions
      .where(occurred_at: Date.new(year).beginning_of_year..Date.new(year).end_of_year)
      .sum { |t| t.earned_points }
  end

  def birthday_month?(date = Date.today)
    birthday.month == date.month
  end
end
