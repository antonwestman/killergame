class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :email, presence: true
  has_many :players
  has_many :targets, through: :players

  def self.ransackable_attributes(auth_object = nil)
    super & %w(username first_name last_name email)
  end
end
