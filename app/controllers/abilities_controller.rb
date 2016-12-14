class AbilitiesController < ApplicationController

    def show
    end

    def update
        @freelancer = Freelancer.find(params[:id])
        @ability = Ability.find(params[:ability_id])
        if @ability.update_attributes(ability_params)
            flash[:success] = "Your profile has been successfully updated!"
            render action :edit
        else
            render action: :edit
        end
    end
end