class V1::GenresController < ApplicationController

def index
	@genres = Genre.all
	render json: { genres: @genres}
end

def create
    @genre = Genre.new(genre_params)
    if @genre.save
		render json: { result: true , genre: @genre, status: :created }
	else
		render json: { result: false, genre: @genre.errors }, status: :unprocessable_entity
	end
end

def update
	if @genre.update(genre_params)
       render json: {genre: @genre}
    else
       render json: {genre: @genre.errors}, status: :unprocessable_entity
    end
end

def destroy
	@genre.destroy
end


private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def genre_params
      params.require(:genre).permit(:genretitle)
    end

end
