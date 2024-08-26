class City < ApplicationRecord
    has_many :temperatures, dependent: :destroy
end
