class PointsEarningService
  STANDARD_RATE = 10

  def initialize(transaction)
    @transaction = transaction
  end

  def call
    base_points = (@transaction.amount * STANDARD_RATE / 100).round
    foreign_country? ? base_points * 2 : base_points
  end

  private

  def foreign_country?
    @transaction.country != 'US'
  end
end
