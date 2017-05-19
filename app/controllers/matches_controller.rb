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
    
private
    def match_params
        params.require(:match).permit(:rounds, :home_team, :away_team, :event_id)
    end
end