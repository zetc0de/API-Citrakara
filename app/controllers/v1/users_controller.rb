class V1::UsersController < ApplicationController

before_action :authenticate_user, only: [ :show, :update, :destroy, :index ]
before_action :set_user, only: [ :show, :update, :destroy] 

	def index
		@users = User.all
		render json: { result: true, user: @users }, status: :ok
	end

	def create
		@user = User.create(create_param)
		if @user.save
			render json: { result: true, user: @user }, status: :created
		else
			render json: { result: false, user: @user.errors }, status: :unprocessable_entity
		end
	end

	def show
		render json: { result: true, user: { id: @user.id, username: @user.username, email: @user.email } }, status: :ok
	end

	def update	
		if @user = User.update(update_param)
			render json: { result: true, user: { id: @user.id, username: @user.username, email: @user.email } }, status: :created
		else
			render json: { result: false, user: @user.errors }, status: :unprocessable_entity
		end
	end

	def destroy
		@user.destroy
		head 204
	end

	private

	def create_param
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end

	def update_param
		params.require(:user).permit(:username, :bio)
	end

	def set_user
		@user = current_user
	end

end