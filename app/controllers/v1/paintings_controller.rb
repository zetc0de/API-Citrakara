class V1::PaintingsController < ApplicationController
before_action :authenticate_user, only: [ :create, :show, :update, :destroy]
before_action :set_painting, only: [ :show, :update, :destroy]

  	def check_configuration
    	render json: { msg: 'configuration_missing'} if Cloudinary.config.api_key.blank?
  	end

	def index
		@paintings = Painting.all
		render json: { painting: @paintings}
	end
# Display individual Painting With Comments
	def show
		@painting = set_painting
		@comments = @painting.comments
		render json: { painting: @painting, comments: @comments }
	end
# Display painting by user id
	def show_by_userid
		@user = User.find(params[:id])
		@painting = @user.paintings
		render json: { painting: @painting }
	end

	def create	
		check_configuration
		@painting = current_user.paintings.create(painting_params)
		if @painting.save
			render json: { result: ' The Painting is successfully Created' , status: :created }
		else
			render json: { result: false, painting: @painting.errors }, status: :unprocessable_entity
		end
	end

	def update
		#Assign painting ID
		@editpainting = Painting.where(id: params[:id])
		if @painting = @editpainting.update(painting_params)
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
	    @painting = Painting.find(params[:id])
	end
	
	def painting_params
		params.permit(:title,:description,:imagepath)
	end

end



