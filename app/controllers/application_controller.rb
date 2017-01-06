class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
        
  # Whitelist sign up form parameters for processing if the come from the 
  # devise sign up form
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # Get a list of freelancer names
  before_filter :get_chars
  before_filter :get_messages
  
  protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:stripe_card_token, :email, :password, :password_confirmation) }
    end
    
  public
    def get_chars
      @freelancers = Freelancer.all
    end
    
    def get_messages
      if user_signed_in?
        @num_msg = Message.where("user_id = ?", current_user.id).size
      end
    end
    
    
end
