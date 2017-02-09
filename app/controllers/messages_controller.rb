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
        if params[:response] == "accept"
            flash[:notice] = "Accepted"
            redirect_to users_path
        elsif params[:response] == "decline"
            flash[:notice] = "Declined"
            redirect_to users_path
        end
    end
    
end