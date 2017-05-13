class MessagesController < ApplicationController
    
    # POST to messages#create
    def create
        # Get the details of the team sending the message and the user the message
        # is being sent to 
        cur_team = Team.find(current_user.profile.team_id)
        rec_user = User.find(params[:user_id])
        
        # Check to see if the user has a message from the current team
        prev_sent = false
        if Message.where("user_id = ?", rec_user.id).where("team_id = ?", cur_team.id).exists?
            prev_sent = true
        end
        
        # Attempt to send an invite message
        if prev_sent == false
            @message = Message.new()
            @message.user_id = params[:user_id]
            @message.team_id = current_user.profile.team_id
            @message.msg_type = "invite"
            @message.subject = "Invite to Team: #{cur_team.name}"
            @message.body = "#{cur_team.name} would like to invite you to join our team!"
            if @message.save()
                flash[:notice] = "Invite sent to #{rec_user.profile.username}"
            else
                flash[:notice] = "We're sorry, something went wrong, please try 
                again later or contact support"
            end
        else
            flash[:notice] = "You have already sent an invite to #{rec_user.profile.username}"
        end
        
        # Redirect users to the index page with a confirmation or error message
        redirect_to users_path
    end
    
    def index
        @messages = current_user.messages
    end
    
    def update
        # If the user has clicked accept on the message
        if params[:message][:response] == "accept"
            # Find the team who sent the message
            @team = Team.find(params[:message][:team])
            # Check to see if the team is full
            if @team.profiles.count < 6
                # Update profile record to add user to team
                Profile.where(:user_id => current_user.id).update_all( :team_id => @team.id)
                # Delete message from database an flash a confirmation message
                Message.find(params[:id]).destroy
                flash[:notice] = "Congratulations! You've joined " + @team.name + "!"
                # Redirect user to their new team
                redirect_to team_path( id: @team.id )
            else
                # Delete message from database an flash a reponse message
                Message.find(params[:id]).destroy
                flash[:notice] = "Sorry, this team is full"
                redirect_to user_messages_path( current_user.id )
            end
        # If the user declines the message, delete the message and refresh the page 
        elsif params[:message][:response] == "decline"
            flash[:notice] = "You declined the team invite"
            Message.find(params[:id]).destroy
            redirect_to user_messages_path(:current_user.id)
        elsif
            flash[:notice] = "We're sorry, something went wrong, please try again later"
            redirect_to users_path
        end
    end
    
end