class FreelancersController < ApplicationController
    
    def show
        scrape_freelancer_details    
    end
    
    def edit
        scrape_freelancer_details
        @freelancer = Freelancer.find(params[:id])
    end
    
    def update
        @freelancer = Freelancer.find(params[:id])
        @ability = Ability.find(params[:ability_id])
        if @ability.update_attributes(ability_params)
            flash[:success] = "Your profile has been successfully updated!"
            redirect_to edit_freelancer_path
        else
            redirect_to edit_freelancer_path
        end
    end
    
protected
    def scrape_freelancer_details
        
        @freelancer = Freelancer.find(params[:id])
        
        # Set the freelancer URL to scrape use Nokogiri to parse the data
        url = "https://www.atlasreactorgame.com/en/character/#{@freelancer.sub_name}/"
        doc = Nokogiri::HTML(open(url))
        
        
        # Store the character data in an instance variable @char_data
        @char_data = Hash.new()
        
        # Scrape images from the page
        @char_data[:ability_img] = "//webcdn.triongames.com/ar/assets/images/char/abilities/abilities_#{@freelancer.sub_name}.png"
        @char_data[:full_img] = doc.css('.bg-mobile-container').to_s.sub(/(.*)(?:url\()/, "").sub(/\);(.*)/, "")
        
        # Scrape character details
        @char_data[:name] = doc.css('#Character_Header_Name').text
        @char_data[:desc] = doc.css('.char-desc').text
        @char_data[:role] = doc.css('.char-bio').first.text.capitalize
        @char_data[:faction] = doc.css('.char-bio').last.text.capitalize
        dossier = doc.css('.dossier-content')
        @char_data[:full_desc] = dossier.at_css('.description').text.sub(/(\(\d\))/, "")
        
        # Scrape character ability data 
        ability_info = doc.css('.character-ability-info')
        x = 0
        @char_data[:ability] = Array.new()
        ability_info.each do |ab_info|
            x+=1
            # Ability name data
            @char_data[:ability][x] = Hash.new()
            @char_data[:ability][x][:name] = ab_info.at_css('h3').text
            @char_data[:ability][x][:description] = ab_info.at_css('.ability-desc').text
            @char_data[:ability][x][:phase] = ab_info.at_css('.bg-ability-phase').to_s.sub(/(.*)(?:phase )/, "").sub(/(?:"><)(.*)/, "").capitalize
            
        end
        
        # Scrape character ability videos
        x = 0
        ability_videos = doc.css('.character-ability-video');
        ability_videos.each do |vid|
            x += 1
            @char_data[:ability][x][:video] = vid.at_css('source').to_s.sub(/(.*)(?:src=")/, "").sub(/(?:"><\/source)(.*)/, "")
        end
    end
    
private
    def ability_params
        params.require(:ability).permit(:ab_index, :damage, :heal, :shield, :range, :cooldown)
    end
end