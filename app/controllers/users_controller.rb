class UsersController < ApplicationController
   # GET to users/
    def index
        num_results = 15
        if !params[:last_id]
            params[:last_id] = 0
        end
            
        @cur_id = params[:last_id]
        if @cur_id.to_i > 0
            @prev_id = @cur_id.to_i - num_results.to_i
        end
        
        if params[:type]
            @users = Profile.where("id > ?", params[:last_id]).where("favorite_role=?", params[:type].downcase.capitalize).first(num_results)
        else
            @users = Profile.where("id > ?", params[:last_id]).first(num_results)
        end
        
        if !@users
            @users = Profile.first(num_results)
            @last_id = 0
        elsif @users.last
            @last_id = @users.last.id
        else
            @last_id = 0
        end
        if params[:type]
            @more = Profile.where("id > ?", @last_id + 1).where("favorite_role=?", params[:type].downcase.capitalize).exists?
        else
            @more = Profile.where(id: @last_id + 1).exists?
        end
    end
   
    # GET to users/id
    def show
        @user = User.find(params[:id])
        @freelancer = Freelancer.find(@user.profile.favorite_freelancer)
    end
end