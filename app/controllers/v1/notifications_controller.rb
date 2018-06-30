class V1::NotificationsController < ApplicationController
  def index
    @notifications = Notification.all.reverse
    render json: @notifications
  end
end
