class V1::FeedbacksController < ApplicationController
before_action :authenticate_user, only: [ :create, :show, :update, :destroy, :index ]
before_action :set_feedback, only: [ :show, :update, :destroy]

  # GET v1/users/:id/feedbacks
  def index
      @users = User.find(params[:id])
    if @users.id == current_user.id  
      @feedbacks = @users.feedbacks.all
      if @feedbacks.empty?
        then 
          render json: { msg: 'No Feedbacks found'}
        else
          render json: { feedback: @feedbacks }
      end
    else
      render json: { msg: 'Unauthorized'}
    end
  end  

  # GET v1/users/:id/feedbacks/:id
  def show
  # render json:  {feedback: Feedback.where(user_id: params[:id])}
    @feedback = Feedback.find(params[:id])
    if @feedback.user_id == current_user.id   # Current user is not allowed to see other user feedbacks 
      render json: { feedback: @feedback }
    else
      render json: { msg: 'unauthorized'}
    end  
  end

  # POST /feedbacks
  def create
    @feedback = current_user.feedbacks.new(feedback_params)
    if @feedback.save
			 render json: { result: true , feedback: @feedback, status: :created }
		else
			 render json: { result: false, feedback: @feedback.errors }, status: :unprocessable_entity
		end
  end

  # PATCH/PUT /feedbacks/1
  def update
       @feedbackid = Feedback.where(id: params[:id])
    if @feedback = @feedbackid.update(feedback_params)
       render json: {feedback: @feedback}
    else
       render json: {feedback: @feedback.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /feedbacks/1
  def destroy
    @feedback.destroy
    head 204
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feedback_params
      params.require(:feedback).permit(:username, :pesan, :user_id)
    end

    
end