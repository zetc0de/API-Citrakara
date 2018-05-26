module V1
class PaintingsController < ApplicationController
before_action :set_painting, only: [:show, :update, :destroy]

	def index
		@paintings = Painting.all
		render json: @paintings
	end

	def show
		render json: @painting
	end

	def create
		@painting = Painting.new(painting_params)
		if @painting.save
			render json: @painting, status: :created
		end
	end

	def update
		if @painting = painting.update(painting_params)
			render json:@painting
		else
			render json: @painting.errors, status: :unprocessable_entity
		end
	end

	def delete
		@painting.destroy
	end

private
	def set_painting
	    @painting = Painting.find(params[:id])
	end

	def painting_params
		params.require(:painting).permit(:title,:description,:imagepath)
	end
end

end