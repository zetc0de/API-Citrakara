class V1::HighlightsController < ApplicationController
before_action :authenticate_user, only: [ :create, :show, :update, :destroy, :index]
#before_action :set_highlight, only: [ :show, :update, :destroy, :like, :dislike ] 

def index
	@highlights = Highlight.all
	render json: { highlights: @highlights },:include => {:painting => {:only => :title }}
end

#user/highlights
def create
	expired_at = (Time.now + 7.days).to_s
	@highlight = Highlight.create(painting_id: params[:painting_id], user_id: current_user.id, expire_date: expired_at )
	if check_balance?
	   @highlight.save 
	   update_balance
		render json: { highlight: @highlight, saldo: @saldo }
	else
		render json: { msg: 'please check your balance' }
	end

end

def check_balance?
	@saldo = current_user.balance.balance_amount
	@saldo > 49000
end

def update_balance
	@current_balance = @saldo - 50000
	current_user.balance.update(balance_amount: @current_balance)
	@saldo = current_user.balance.balance_amount
end

def days_left
	#@created = Highlight.pluck(:expire_date)
	#@days = distance_of_time_in_words_to_now(@created)
end


end
