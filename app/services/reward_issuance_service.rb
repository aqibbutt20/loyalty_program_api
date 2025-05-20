class RewardIssuanceService
  def initialize(user)
    @user = user
  end

  def call
    issue_free_coffee_rewards
    issue_movie_tickets_reward
  end

  private

  def issue_free_coffee_rewards
    if @user.total_points_in_month >= 100
      @user.rewards.create!(name: 'Free Coffee', issued_at: Time.current)
    end

    if @user.birthday_month?
      @user.rewards.create!(name: 'Free Coffee', issued_at: Time.current)
    end
  end

  def issue_movie_tickets_reward
    return unless new_user_spending_met?

    @user.rewards.create!(name: 'Free Movie Tickets', issued_at: Time.current)
  end

  def new_user_spending_met?
    first_transaction = @user.transactions.order(:occurred_at).first
    return false unless first_transaction

    days_since_first_transaction = (Time.current - first_transaction.occurred_at) / 1.day
    days_since_first_transaction <= 60 && @user.transactions.sum(:amount) > 1000
  end
end
