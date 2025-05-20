class TransactionsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    transaction = user.transactions.new(transaction_params)

    if transaction.save
      render json: { 
        transaction: transaction,
        earned_points: transaction.earned_points
      }, status: :created
    else
      render json: { errors: transaction.errors }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :country, :occurred_at)
  end
end
