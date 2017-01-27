class Place < ApplicationRecord
  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    super & %w(name)
  end
end
