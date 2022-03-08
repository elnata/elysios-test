class Input < ApplicationRecord
  enum unit_measurement: [:KG, :T]
  has_many :Lot, dependent: :destroy
end
