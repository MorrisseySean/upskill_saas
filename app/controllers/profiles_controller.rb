class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :only_current_user 
    
    # GET to /users/:users_id/profile/new
    def new
        # Render blank profile details form
        @profile = current_user.build_profile
    end
    
    # POST to /users/:users_id/profile
    def create
        # Create a profile linked to this user
        @profile = current_user.build_profile(profile_params)
        if @profile.save
            flash[:success] = "Your profile has been successfully updated!"
            redirect_to user_path( id: params[:user_id] )
        else
            flash[:notice] = flash[:notice].to_a.concat @profile.errors.full_messages
            render action: :new
        end
    end
    
    # GET to /users/:user_id/profile/edit
    def edit
        @user = User.find(params[:user_id])
        @profile = @user.profile
    end
    
    # PATCH to /user/:user_id/profile
    def update
        @user = User.find(params[:user_id])
        @profile = @user.profile
        if params[:glyphtag]
            if @profile.update_attributes(profile_params)
                flash[:success] = "Your profile has been successfully updated!"
                redirect_to user_path( id: params[:user_id] )
            else
                render action: :edit
            end
        else
            toggle_freeagent
        end
    end
    
    
        
    private
        def profile_params
            params.require(:profile).permit(:username, :glyphtag, :favorite_role, :favorite_freelancer, :bio, :avatar)
        end
        
        def only_current_user
            @user = User.find(params[:user_id])
            redirect_to(root_url) unless @user == current_user
        end
        
        def toggle_freeagent
        @profile = current_user.profile
            if @profile.update_attributes(freeagent: !@profile.freeagent)
                flash[:notice] = "Free Agent status updated!"
                redirect_to root_path
            end
        end
end