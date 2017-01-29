class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :email, presence: true

  def self.ransackable_attributes(auth_object = nil)
    super & %w(username first_name last_name email)
  end
end
