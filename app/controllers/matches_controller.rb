class MatchesController < ApplicationController
    def create
        # Create a new match with the parameters given by the admin
        @match = Match.new(match_params)
        # Add a reference to the match to both teams
        @match.teams << Team.find(params[:match][:home_team])
        @match.teams << Team.find(params[:match][:away_team])
        # Save the match to the database
        @new_match.save
        #Redirect back to the event page
        redirect_to event_path(params[:match][:event_id])
    end
    
    def show
        @match = Match.find(params[:id])
        @home_team = Team.find(@match.home_team)
        @away_team = Team.find(@match.away_team)
        @home_captain = false
        @away_captain = false
        # Check if the current user is captain of either team
        if user_signed_in?
            if current_user.id == @home_team.user_id
                @home_captain = true
            elsif current_user.id == @away_team.user_id
                @away_captain = true
            end
        end
    end
    
private
    def match_params
        params.require(:match).permit(:round, :home_team, :away_team, :event_id)
    end
end