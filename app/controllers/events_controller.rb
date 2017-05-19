class EventsController < ApplicationController
    
    
    def index
      is_captain
      @events = Event.all
      @event = Event.new
    end
    
    def show
      is_captain
      @event = Event.find(params[:id])
      @teams = @event.teams
    end
    
    def update
      # Get the event & list of event teams
      @event = Event.find(params[:id])
      @event_teams = @event.teams
      
      # If the user is trying to remove a team from the league
      if params[:event][:msg] == "leave"
        # Check if the team is already part of the event
        @new_team = Team.find(params[:event][:team_id])
        if @event_teams.include?@new_team
          
          # Remove the team and output a message to the user
          @event.teams.delete(@new_team)
          flash[:danger] = @new_team.name + " has left " + @event.name
        end
        
      # If a team is trying to join the league
      elsif params[:event][:msg] == "join"
        # Check if the team is already part of the event
        # Flash an error message notifying the user that they have already joined
        @new_team = Team.find(params[:event][:team_id])
        if @event_teams.include?@new_team
          flash[:danger] = "Your team is already signed up for " + @event.name + "!"
        # Otherwise, add the team to the event and flash a confirmation message
        else
          @event.teams << @new_team
          flash[:success] = "Your team has signed up for " + @event.name + "!"
        end
        
      # Toggle the event status between open/close
      elsif params[:event][:msg] == "close"
        if @event.status == "open"
          @event.status = "closed"
        else
          @event.status = "open"
        end
        @event.save
      end
      
      # Return to event page
      redirect_to event_path( @event.id )
    end
    
    private
      # Function to confirm if the user is the captain of a team
      def is_captain
        @captain = false
        # Check if the user is signed in and has a profile
        if user_signed_in?
          if current_user.profile 
            # Check if the user is part of a team and find the team
            if current_user.profile.team_id > 0
              team = Team.find(current_user.profile.team_id)
              # If the user is the captain of the team, check that they have 
              # the required amount of players on the team and set captain to true
              if current_user.id == team.user_id
                if team.profiles.count >= 4
                  @captain = true
                end
              end
            end
          end
        end
      end
end