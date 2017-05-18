class EventsController < ApplicationController
    def index
      @events = Event.all
      
     # Check if user is the captain of a team which can sign up to an event
      @captain = false
      if user_signed_in?
          if current_user.profile 
              if current_user.profile.team_id > 0
                  team = Team.find(current_user.profile.team_id)
                  if current_user.id == team.user_id
                      if team.profiles.count >= 4
                          @captain = true
                          @message = Message.new()
                      end
                  end
              end
          end
      end
        
      @event = Event.new
    end
    
    def show
      @event = Event.find(params[:id])
      @teams = @event.teams
    end
    
    def update
      @event = Event.find(params[:id])
      @new_team = Team.find(params[:event][:team_id])
      @event_teams = @event.teams
      if @event_teams.include?@new_team
        flash[:danger] = "Your team is already signed up for " + @event.name + "!"
      else
        @event.teams << @new_team
        flash[:success] = "Your team has signed up for " + @event.name + "!"
      end
      redirect_to team_path( params[:event][:team_id] )
    end
end