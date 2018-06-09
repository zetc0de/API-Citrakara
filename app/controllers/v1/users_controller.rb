class V1::UsersController < ApplicationController
before_action :authenticate_user, only: [ :show, :update, :destroy, :index, :change_password ]
before_action :set_user, only: [ :show, :update, :destroy, :change_password] 

	def index
		@users = User.all
		render json: { result: true, user: @users }, status: :ok		
	end
 	
	def create
		@user = User.create(create_param)
		if @user.save
			UserMailer.welcome_email(@user).deliver_now
			render json: { result: true, user: @user }, status: :created
		else
			render json: { result: false, user: @user.errors }, status: :unprocessable_entity
		end
	end

	def show
		render json: { result: true, user: { id: @user.id, username: @user.username, email: @user.email } }, status: :ok
	end

	def update	
		if @user.update(update_param)
			render json: { result: true, user: @user  }, status: :created
		else
			render json: { result: false, user: @user.errors }, status: :unprocessable_entity
		end
	end

	def destroy
		@user.destroy
		head 204
	end

	def change_password
		if !@user.authenticate(params[:current_password]) # check current_user password
		render json: { msg: 'password salah'}
			else
		@user.update(changepassword_param)
		render json: { msg: 'password changed'}
		end
	end


private

	def create_param
		params.require(:user).permit(:username, :email, :password, :password_confirmation, :artist)
	end

	def update_param
		params.require(:user).permit(:username, :bio, :telp, :password, :password_confirmation)
	end

	def set_user
		@user = current_user
	end

	def changepassword_param
		params.permit(:password, :password_confirmation)
	end
end