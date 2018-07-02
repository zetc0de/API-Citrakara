class V1::NotificationsController < ApplicationController
  def index
    @notifications = Notification.all.reverse
    render json: @notifications
  end

  def filter_by_user_id
	@user = User.find(params[:id])
	@notify = @user.notifications.reverse
    render json: { Notification: @notify },:include => {:user => {:only => :username }, :painting => {:only => :id }}
  end
end
