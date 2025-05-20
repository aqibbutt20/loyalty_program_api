class RewardsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: user.rewards
  end

  def create
    user = User.find(params[:user_id])
    reward = user.rewards.build(reward_params)

    if reward.save
      render json: reward, status: :created
    else
      render json: { errors: reward.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def reward_params
    params.require(:reward).permit(:name, :description, :reward_type, :issued_at, :metadata)
  end
end
