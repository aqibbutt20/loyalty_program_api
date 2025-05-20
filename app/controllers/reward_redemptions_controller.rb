class RewardRedemptionsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: user.reward_redemptions.includes(:reward)
  end

  def create
    user = User.find(params[:user_id])
    reward = Reward.find(params[:reward_redemption][:reward_id])
    points_needed = params[:reward_redemption][:points_spent].to_i

    current_points = user.transactions.sum { |t| t.earned_points }
    total_spent = user.reward_redemptions.sum(:points_spent)

    if current_points - total_spent >= points_needed
      redemption = user.reward_redemptions.build(
        reward: reward,
        points_spent: points_needed,
        redeemed_at: Time.current
      )

      if redemption.save
        render json: redemption, status: :created
      else
        render json: { errors: redemption.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Insufficient points" }, status: :unprocessable_entity
    end
  end
end
