class User < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :rewards, dependent: :destroy

  validates :name, :email, :birthday, presence: true
  validates :email, uniqueness: true

  def birthday_month?(date = Date.current)
    birthday.month == date.month
  end

  def total_points_in_month(date = Date.current)
    transactions
      .where(occurred_at: date.beginning_of_month..date.end_of_month)
      .sum(&:earned_points)
  end
end
