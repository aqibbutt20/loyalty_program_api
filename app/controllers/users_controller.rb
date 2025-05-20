class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def points_summary
    user = User.find(params[:id])
    date = Date.today
    monthly_points = user.total_points_in_month(date)
    yearly_points = user.total_points_in_year(date.year)

    render json: {
      user_id: user.id,
      monthly_points: monthly_points,
      yearly_points: yearly_points
    }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :birthday)
  end
end
