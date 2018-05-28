class ApplicationController < ActionController::API
	include Knock::Authenticable




	before_action :authenticate_user, only: [ :show, :update, :destroy, :index ]
end
