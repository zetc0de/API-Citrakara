class V1::CommentsController < ApplicationController
before_action :set_comment, only: [ :show, :update, :destroy]
before_action :set_painting
before_action :authenticate_user, only: [:index, :create,  :show, :update, :destroy]

    def index
# Display painting with comments that associate with it
        @painting = Painting.find(params[:painting_id])
        @comments = @painting.comments
        render json: { comment: @comments }
    end
    
    def show
        render json: { comment: @comment }
    end

    def create
        @comment = @painting.comments.new(comment_params)
        if @comment.save
            paintingid = @painting.id
            userid = @painting.user_id
            action_by = current_user.username
            action_by_id = current_user.id
            @notify = Notification.create(notif: "Notification New Comment From " + action_by, user_id: userid, painting_id: paintingid, actionby: action_by_id)
            render json: { result: true, comment: @comment, notify: @notify }, status: :created
        else
            render json: { result: false, comment: @comment.errors }, status: :unprocessable_entity
        end
    end

    def destroy
		@comment.destroy
        head 204
	end

private
    def set_painting
        @painting = Painting.find(params[:painting_id])
    end

	def set_comment
	    @comment = Comment.find(params[:painting_id])
	end

	def comment_params
		params.require(:comment).permit(:content,:user_id )
    end


end
