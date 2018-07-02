class V1::HighlightsController < ApplicationController
before_action :authenticate_user, only: [ :create, :show, :update, :destroy, :index]
#before_action :set_highlight, only: [ :show, :update, :destroy, :like, :dislike ] 

def index
	@highlights = Highlight.all
	render json: { highlights: @highlights }
end

#user/highlights
def create
	expired_at = (Time.now + 7.days).to_s
	@highlight = Highlight.create(painting_id: params[:painting_id], user_id: current_user.id, expire_date: expired_at )
	if @highlight.save
		render json: { highlight: @highlight }
	else
		render json: { msg: @highlight.errors }
	end

end





end
