class TransactionsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: user.transactions
  end

  def create
    user = User.find(params[:user_id])
    transaction = user.transactions.build(transaction_params)

    if transaction.save
      render json: {
        transaction: transaction,
        earned_points: transaction.earned_points
      }, status: :created
    else
      render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :country, :occurred_at)
  end
end
