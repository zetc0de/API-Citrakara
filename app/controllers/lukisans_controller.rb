class LukisansController < ApplicationController
  before_action :set_lukisan, only: [:show, :update, :destroy]

  # GET /lukisans
  def index
    @lukisans = Lukisan.all

    render json: @lukisans
  end

  # GET /lukisans/1
  def show
    render json: @lukisan
  end

  # POST /lukisans
  def create
    @lukisan = Lukisan.new(lukisan_params)

    if @lukisan.save
      render json: @lukisan, status: :created, location: @lukisan
    else
      render json: @lukisan.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lukisans/1
  def update
    if @lukisan.update(lukisan_params)
      render json: @lukisan
    else
      render json: @lukisan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lukisans/1
  def destroy
    @lukisan.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lukisan
      @lukisan = Lukisan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lukisan_params
      params.require(:lukisan).permit(:title, :description, :imagepath)
    end
end
