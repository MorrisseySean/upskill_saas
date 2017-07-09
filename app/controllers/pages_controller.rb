class PagesController < ApplicationController
    # GET request for / which is the home page
    def home
        @events = Event.where("status == 'open'");
        @users = Profile.last(4);
        @teams = Team.last(4);
    end
    
    def about
    end
    
    
    
    def leaguesignup
    end
end