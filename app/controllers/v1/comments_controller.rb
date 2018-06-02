class V1::CommentsController < ApplicationController
before_action :set_comment, only: [:show, :update, :destroy]
before_action :set_painting
before_action :authenticate_user, only: [:create,  :show, :update, :destroy]

    def index
        @comments = Comment.all
		render json: @comments
    end
    
    def show
        render json: @comment
    end

    def create
        #@comment = current_user.comments.create(comment_params)
        @comment = Comment.create(content: params[:content],painting_id: params[:painting_id],user_id: current_user.id)
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
	end

private
    def set_painting
        @painting = Painting.find(params[:painting_id])
    end

	def set_comment
	    @comment = Comment.find(params[:painting_id])
	end

	def comment_params
		params.permit(:content,:painting_id,:user_id)
    end


end
