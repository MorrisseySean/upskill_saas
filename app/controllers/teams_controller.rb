class TeamsController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @team = Team.new()
    end
    
    def show
        @team = Team.find(params[:id])
    end
    
    def create
        @team = Team.new(profile_params)
        if @team.save
            flash[:success] = "Your team, #{@team.name}, has been successfully created!"
            redirect_to team_path( id: @team.id )
        else
            flash[:notice] = flash[:notice].to_a.concat @profile.errors.full_messages
            render action: :new
        end
    end
    
    private
        def profile_params
            params.require(:team).permit(:user_id, :name, :description, :avatar)
        end

end