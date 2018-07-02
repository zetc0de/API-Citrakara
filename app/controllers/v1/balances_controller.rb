class V1::BalancesController < ApplicationController
before_action :authenticate_user, only: [ :create, :show, :update, :destroy, :index ]

def index
end

def create
end


end
