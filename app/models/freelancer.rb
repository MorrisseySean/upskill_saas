class Freelancer < ApplicationRecord
    has_many :abilities
    has_and_belongs_to_many :matches
end