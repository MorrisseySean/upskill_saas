class AdminController < ApplicationController
    def index
        if user_signed_in?
            @event = Event.new()
            if current_user.user_type != "admin"
                #redirect_to root_url
            end
        else
            redirect_to root_path
        end
    end
    
    def create
        if params[:event][:form] == 'create_event'
            @event = Event.new(event_params)
            @event.save
            flash[:success] = "Event " + params[:event][:name] + " has been created!"
            redirect_to admin_index_path
            
        end
    end
private
    def event_params
        params.require(:event).permit(:name, :date, :time, :event_type, :num_matches)
    end
end