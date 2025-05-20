class RewardsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: user.rewards
  end
end
