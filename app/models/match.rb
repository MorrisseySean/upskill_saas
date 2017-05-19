class Match < ApplicationRecord
    belongs_to :event
    has_and_belongs_to_many :teams
    has_and_belongs_to_many :freelancers
    
    has_attached_file   :home_pb,
                        :styles => { :medium => "300x300>", :thumb => "100x100>"},
                        :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :home_pb, :content_type => /\Aimage\/.*\Z/
    
    has_attached_file   :away_pb,
                        :styles => { :medium => "300x300>", :thumb => "100x100>"},
                        :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :away_pb, :content_type => /\Aimage\/.*\Z/
    
    has_attached_file   :home_end,
                        :styles => { :medium => "300x300>", :thumb => "100x100>"},
                        :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :home_end, :content_type => /\Aimage\/.*\Z/
    
    has_attached_file   :home_end,
                        :styles => { :medium => "300x300>", :thumb => "100x100>"},
                        :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :home_end, :content_type => /\Aimage\/.*\Z/
    
end