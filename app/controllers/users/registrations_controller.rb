class Users::RegistrationsController < Devise::RegistrationsController
    # Extend default devise gem behaviour, so users with pro account 
    # will save with a stripe subscription method. Otherwise do the default
    # sign up process as a basic user.
    def create
        super do |resource|
            if params[:plan]
                resource.plan_id = params[:plan]
                if resource.plan_id == 2
                    resource.save_with_subscription
                else
                    resource.save
                end
            else
                resource.plan_id = 1
            end    
        end
    end
end