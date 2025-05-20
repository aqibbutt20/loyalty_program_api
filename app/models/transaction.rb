class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :country, :occurred_at, presence: true

  def foreign_country?
    country != 'US'
  end

  def earned_points
    base_points = (amount / 100).floor * 10
    foreign_country? ? base_points * 2 : base_points
  end
end
