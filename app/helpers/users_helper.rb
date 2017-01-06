module UsersHelper
    def job_title_icon
        if @user.profile.job_title == "Developer"
            "<i class='fa fa-code'></i>".html_safe
        elsif @user.profile.job_title == "Entrepreneur"
            "<i class='fa fa-lightbulb-o'></i>".html_safe
        elsif @user.profile.job_title == "Investor"
            "<i class='fa fa-dollar'></i>".html_safe
        end
    end
    
    # Disables a button if users are currently on the associated page
    def disable_button(type)
        if type.downcase == params['type']
            "disabled"
        elsif type == "All" && !params['type']
            "disabled"
        else
            ""
        end
    end
    
    
    
end