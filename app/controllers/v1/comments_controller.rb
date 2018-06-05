class V1::CommentsController < ApplicationController
before_action :set_comment, only: [:create, :show, :update, :destroy]
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
        @comment = Comment.new(comment_params)
        if @comment.save
            render json: { result: true, comment: @comment }, status: :created
        else
            render json: { result: false, comment: @comment.errors }, status: :unprocessable_entity
        end
    end

# Blom ada fitur edit comment 
#   def update
#        if @comment = @comment.update(comment_params)
#            render json: @comment
#        else 
#            render json: @comment.errors, status: unprocessable_entity
#        end
#    end

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
		params.require(:comment).permit(:content,:painting_id,:user_id)
    end


end
