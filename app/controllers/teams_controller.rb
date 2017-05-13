class TeamsController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @team = Team.new()
    end
    
    def show
        @team = Team.find(params[:id])
        @team_members = Profile.where("team_id = ?", @team.id)
    end
    
    def create
        @team = Team.new(profile_params)
        if @team.save
            current_user.profile.update_attributes(team_id: @team.id)
            flash[:success] = "Your team, #{@team.name}, has been successfully created!"
            redirect_to team_path( id: @team.id )
        else
            flash[:notice] = flash[:notice].to_a.concat @profile.errors.full_messages
            render action: :new
        end
    end
    
    private
        def profile_params
            params.require(:team).permit(:user_id, :name, :description, :firepower, :frontline, :support, :any, :avatar)
        end

end