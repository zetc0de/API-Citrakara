class V1::PaintingsController < ApplicationController
before_action :authenticate_user, only: [ :create, :show, :update, :destroy]
before_action :set_painting, only: [ :show, :update, :destroy, :like, :dislike ] 

# Check cloudinary Config
  	def check_configuration
    	render json: { msg: 'configuration_missing'} if Cloudinary.config.api_key.blank?
  	end

	def index
		@paintings = Painting.all.order(created_at: :desc)
		render json: { paintings: @paintings}, :include => {:user => {:only => :username }, :genre => {:only => :genretitle }}

	end
# Display individual Painting With Comments
	def show
		@painting = set_painting
		@comments = @painting.comments
		render json: { painting: @painting, comments: @comments },:include => {:user => {:only => :username }}
	end
# Display painting by user id /v1/user/:id/paintings(.:format) 
	def show_by_userid
		@user = User.find(params[:id])
		@painting = @user.paintings
		render json: { painting: @painting },:include => {:user => {:only => :username }, :genre => {:only => :genretitle }}
	end
# Display painting by genre /v1/genre/:id/paintings(.:format)
	def show_by_genre
		@genre = Genre.find(params[:id])
		@painting = @genre.paintings
		render json: { painting: @painting },:include => {:user => {:only => :username }, :genre => {:only => :genretitle }}
	end
# Create painting /v1/paintings(.:format)
	def create	
		check_configuration
		if current_user.artist?	    # check if current user is artist or not
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
		if current_user.artist?		# check if current user is artist or not	
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
			@painting.destroy
			render json: { msg: 'Painting Deleted'}
		else
			render json: { msg: 'Unauthorized'}
		end
	end

# favorite painting /v1/paintings
	def favorite
		@favorite = Painting.find(params[:id])
		type = params[:type]
    	if type == "favorite"
			current_user.favorites << @favorite
			render json: { msg: 'Added to favorites'}
		elsif type == "unfavorite"
			current_user.favorites.delete(@favorite)
			render json: { msg: 'Removed from favorites'}
		else
			# Type missing, nothing happens
			render json: { msg: 'Nothing happened'}
		end
	end
	
# Like painting 
	def	like
	 if @painting.liked_by current_user	
	 	notify_new_like
		render json: { like: @painting.get_likes.size , notify: @notify }
		 else
			render json: { like: 'not allowed' }
		end
	end

# dislike painting
	def dislike
		if @painting.disliked_by current_user
			render json: { like: @painting.get_likes.size }
		else
			render json: { like: 'not allowed' }
		end
	end

def notify_new_like
	userid = @painting.user_id
	paintigid = params[:id]
	action_by = current_user.username
	action_by_id = current_user.id
	@notify = Notification.create(notif: "Notification New Like From " +action_by,user_id: userid,painting_id: paintigid, actionby: action_by_id)	 
end

def search
	@result = Painting.search(params[:search]).order(created_at: :desc )
	render json: { result: @result }, :include => {:user => {:only => :username }, :genre => {:only => :genretitle }}
end

private

	def set_painting
	    @painting = Painting.find(params[:id])
	end
	
	def painting_params
		params.permit(:title,:description,:imagepath,:genre_id)
	end


end



