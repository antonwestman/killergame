class User < ApplicationRecord
  validates :username,
            :first_name,
            :last_name,
            :email, presence: true

  def self.ransackable_attributes(auth_object = nil)
    super & %w(username first_name last_name email)
  end
end
