class Lot < ApplicationRecord
  enum unit_measurement: [:KG, :T]
  validates :name, :weight, :unit_measurement, presence: true
end
