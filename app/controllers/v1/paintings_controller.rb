class V1::PaintingsController < ApplicationController
before_action :authenticate_user, only: [ :create, :show, :update, :destroy]
before_action :set_painting, only: [ :show, :update, :destroy]

# Check cloudinary Config
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
# Display painting by user id /v1/user/:id/paintings(.:format) 
	def show_by_userid
		@user = User.find(params[:id])
		@painting = @user.paintings
		render json: { painting: @painting }
	end
# Create painting /v1/paintings(.:format)
	def create	
		check_configuration
		if current_user.artist?	
			@painting = current_user.paintings.create(painting_params)
			if @painting.save
				render json: { result: ' The Painting is successfully Created' , status: :created }
			else
				render json: { result: false, painting: @painting.errors }, status: :unprocessable_entity
			end
		else 
			render json: { msg: 'You can not upload a painting, you are not an artist'}
		end	
	end
# Edit painting v1/paintings/:id(.:format)  
	def update
		if current_user.artist?			
			#Assign painting ID
			@editpainting = Painting.where(id: params[:id])
			if @painting = @editpainting.update(painting_params)
				render json: { painting: @painting } 
			else
				render json: { painting: @painting.errors }, status: :unprocessable_entity
			end
		else 
			render json: { msg: 'You can not edit a painting, you are not an artist'}
		end	
	end

#delete painting helper
def allow_painting_delete?(painting)
  return false unless current_user
  @painting.user_id == current_user.id
end

# delete painting /v1/paintings/:id(.:format) 
	def destroy
		@painting = Painting.find(params[:id])
		if allow_painting_delete?(@painting)
		then	
			@painting.destroy
			render json: { msg: 'Painting Deleted'}
		else
			render json: { msg: 'Unauthorized'}
		end
	end

private

	def set_painting
	    @painting = Painting.find(params[:id])
	end
	
	def painting_params
		params.permit(:title,:description,:imagepath)
	end

end



