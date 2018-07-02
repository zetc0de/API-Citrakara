class V1::TransactionsController < ApplicationController
before_action :authenticate_user, only: [ :create, :show, :update, :destroy]
before_action :set_transaction, only: [ :show] 

def check_configuration
   	render json: { msg: 'configuration_missing'} if Cloudinary.config.api_key.blank?
end
# Display transaction history, user/transactions
def index
	@transactions = current_user.transactions.all.order(created_at: :desc)
	render json: { transactions: @transactions }
end

def indexall
	@transactions = Transaction.all.order(created_at: :desc)
	render json: { all_transactions: @transactions }
end

# Create Transactions user/:id/transactions
def create	
	check_configuration
	@transaction = current_user.transactions.create(transaction_params)
	if @transaction.save
		render json: { result: true, msg:' Transaction is created'} , status: :created
	else
		render json: { result: false, painting: @ptransaction.errors }, status: :unprocessable_entity
	end
end

private

def transaction_params
	params.permit(:amount,:bukti)
end

def set_transaction
    @transaction = Transaction.find(params[:id])
end





end
