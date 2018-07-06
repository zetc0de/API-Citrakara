class V1::BalancesController < ApplicationController
before_action :authenticate_user, only: [ :create, :show, :update, :destroy, :index ]

def index
	@balances = current_user.balance
	render json: { balances: @balances }
end

def create
	#manual by CMS
end


end
