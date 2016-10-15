class Place < ApplicationRecord
  validates :name, presence: true
end
