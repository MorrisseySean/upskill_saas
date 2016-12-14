class Ability < ApplicationRecord
    belongs_to :freelancer
    has_many :mods
end