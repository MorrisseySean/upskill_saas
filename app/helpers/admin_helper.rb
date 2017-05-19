module AdminHelper
    def update_freelancers
        url = 'https://www.atlasreactorgame.com/en/characters/'
        doc = Nokogiri::HTML(open(url))
        char_names = doc.css('.character-sub-header')
        img_track = 0
        char_names.each do |name|
            real_name = name.text
            sub_name = name.text.gsub(/[^0-9a-z]/i, '').downcase
            image = doc.css('.character-portrait')[img_track].to_s.sub(/(.*)(?:url\()/, "").sub(/\);(.*)/, "")
            img_track += 1
            f = Freelancer.find_by_sql ["SELECT * FROM freelancers WHERE name = ?", real_name]
            if f.size < 1
                new_freelancer = Freelancer.new()
                new_freelancer.name = real_name
                new_freelancer.sub_name = sub_name
                new_freelancer.image_url = image
                
                if new_freelancer.save
                    5.times do |x|
                        new_ability = Ability.new()
                        new_ability.freelancer_id = new_freelancer.id
                        new_ability.ab_index = x
                        new_ability.save
                        8.times do |y|
                            new_mod = Mod.new()
                            new_mod.ability_id = new_ability.id
                            new_mod.save
                        end
                    end
                end
            end
        end
    end
end