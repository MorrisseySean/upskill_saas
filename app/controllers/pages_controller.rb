class PagesController < ApplicationController
    # GET request for / which is the home page
    def home
    end
    
    def about
    end
    
    def admin
        if user_signed_in?
            if current_user.user_type != "admin"
                redirect_to root_url
            end
        else
            redirect_to root_url
        end
    end
end