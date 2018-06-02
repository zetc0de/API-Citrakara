class V1::FeedbacksController < ApplicationController
  before_action :authenticate_user, only: [ :create, :show, :update, :destroy, :index ]
  before_action :set_feedback, only: [ :show, :update, :destroy]

  # GET /feedbacks
  def index
    @feedbacks = Feedback.all

    render json: { feedback: @feedback }
  end

  # GET /feedbacks/1
  def show
    render json:  {feedback: Feedback.where(user_id: params[:id])}
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
    #masih belum 100% karena tiap update malah ke update semua
    if @feedback = current_user.feedbacks.update(feedback_params)
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