class V1::PaintingsController < ApplicationController
<<<<<<< HEAD
before_action :authenticate_user, only: [ :create, :show, :update, :destroy, :index ]

before_action :set_painting, only: [ :create, :show, :update, :destroy]
=======
before_action :set_painting, only: [:show, :update,:destroy]
>>>>>>> bb1694d5f28b1efc4489000f38d7e6a917b3ce2e

	def index
		@paintings = Painting.all
		render json: { painting: @paintings }
	end

	def show
		render json: { painting: @painting }
	end

<<<<<<< HEAD
	def create
=======
	def create	
>>>>>>> bb1694d5f28b1efc4489000f38d7e6a917b3ce2e
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
<<<<<<< HEAD

=======
	def set_painting
	     @painting = Painting.find(params[:id])
	end
>>>>>>> bb1694d5f28b1efc4489000f38d7e6a917b3ce2e

	def painting_params
		params.require(:painting).permit(:title,:description,:imagepath)
	end

<<<<<<< HEAD
	def set_painting
		@painting = Painting.find(params[:id])
	end
=======
	#def set_painting
	#	@painting = current_painting
	#end
>>>>>>> bb1694d5f28b1efc4489000f38d7e6a917b3ce2e




