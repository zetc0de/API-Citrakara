  class V1::PasswordsController < ApplicationController
      def forgot
        if params[:email].blank?
          return render json: {error: 'Email not present'} # Check user's email, is it present ?
        end
        @user = User.find_by(email: params[:email])        # Check user by user's email
        if @user.present?
           @user.generate_password_token!                   # if user is found, generate forgot password token
           SendTokenMailer.forgot_password(@user).deliver_now   # Send user token via email
           render json: {status: 'Token generated, please check your email'}, status: :ok
          else
             render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
          end
        end
        
        def reset
          token = params[:token].to_s
          if params[:email].blank?
            return render json: {error: 'Token not present'}
          end
          user = User.find_by(reset_password_token: token)
          if user.present? && user.password_token_valid?
            if user.reset_password!(params[:password])
              render json: {status: 'Password Changed !'}, status: :ok
            else
              render json: {error: user.errors.full_messages}, status: :unprocessable_entity
            end
          else
              render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
          end
        end
    end