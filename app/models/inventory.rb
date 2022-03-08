class Inventory < ApplicationRecord
    has_many :Input
    enum unit_measurement: [:KG, :T]
end
