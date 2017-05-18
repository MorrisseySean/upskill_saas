class EventsController < ApplicationController
    def index
      @events = Event.all
      
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
        
      @event = Event.new
    end
    
    def update
      @event = Event.find(params[:id])
      @new_team = Team.where(:id => params[:event][:team_id])
      @event.teams << @new_team
      redirect_to team_path( params[:event][:team_id] )
    end
end