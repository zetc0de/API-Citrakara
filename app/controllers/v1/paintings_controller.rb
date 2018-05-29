class V1::PaintingsController < ApplicationController
before_action :authenticate_user, only: [ :create, :show, :update, :destroy]
before_action :set_painting, only: [ :show, :update, :destroy]


	def index
		@paintings = Painting.all
		@comments = Comment.all
		#render json: { painting: @paintings }
		render json: { painting: @paintings, comment: @comments }
	end
	def show
		#@comments = Comment.find(params[:painting_id])
		render json: { painting: @painting, comments: @comments }
	
	end
	def create	
		@painting = current_user.paintings.create(painting_params)
		if @painting.save
			render json: { result: true , painting: @painting, status: :created }
		else
			render json: { result: false, painting: @painting.errors }, status: :unprocessable_entity
		end
	end
	def update
		if @painting = current_user.paintings.update(painting_params)
			render json: { painting: @painting }
		else
			render json: { painting: @painting.errors }, status: :unprocessable_entity
		end
	end
	def destroy
		@painting.destroy
		head 204
	end

private

	def set_painting
	     @painting = Painting.find(params[:user_id])
	end
	def painting_params
		params.require(:painting).permit(:title,:description,:imagepath)
	end
end



