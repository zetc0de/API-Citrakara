class ApplicationController < ActionController::API
	include Knock::Authenticable
<<<<<<< HEAD



=======
	before_action :authenticate_user, only: [ :show, :update, :destroy, :index ]
>>>>>>> bb1694d5f28b1efc4489000f38d7e6a917b3ce2e
end
