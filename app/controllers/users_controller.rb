class UsersController < ApplicationController
   before_action :authenticate_user!
   
   # GET to users/
   def index
        @users = User.includes(:profile)
   end
   
    # GET to users/id
    def show
        @user = User.find(params[:id])
        @freelancer = Freelancer.find(@user.profile.favorite_freelancer)
    end
end