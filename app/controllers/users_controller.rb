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
            @users = Profile.where("team_id = 0").where("id > ?", params[:last_id]).where("favorite_role=?", params[:type].downcase.capitalize).first(num_results)
        else
            @users = Profile.where("team_id = 0").where("id > ?", params[:last_id]).first(num_results)
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
            @more = Profile.where("team_id = 0").where("id > ?", @last_id + 1).where("favorite_role=?", params[:type].downcase.capitalize).exists?
        else
            @more = Profile.where("team_id = 0").where(id: @last_id + 1).exists?
        end
        
        # Check if user is able to invite players to a team
        @captain = false
        if user_signed_in?
            if current_user.profile 
                if current_user.profile.team_id > 0
                    team = Team.find(current_user.profile.team_id)
                    if current_user.id == team.user_id
                        if Profile.where("team_id = ?", team.id).size < 6
                            @captain = true
                            @message = Message.new()
                        end
                    end
                end
            end
        end
        
    end
   
    def create
        flash[:notice] = "Success!"
    end
    
    # GET to users/id
    def show
        @user = User.find(params[:id])
        @freelancer = Freelancer.find(@user.profile.favorite_freelancer)
    end
end