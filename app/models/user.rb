class User < ApplicationRecord
  rolify
  acts_as_paranoid
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :email, presence: true
  has_many :players, class_name: Game::Player
  has_many :targets, through: :players
  has_and_belongs_to_many :roles, join_table: :users_roles

  before_destroy :scramble_user_info_and_transfer_game_data

  def self.ransackable_attributes(auth_object = nil)
    super & %w[username first_name last_name email]
  end

  private

  def scramble_user_info_and_transfer_game_data
    transaction do
      update(email: "DELETED_USER_WITH_ID#{id}@foo",
             first_name: 'Joe',
             last_name: 'Doe',
             username: 'DELETED',
             uid: "DELETED_USER_WITH_ID#{id}@foo")
      transfer_game_data
    end
  end

  def transfer_game_data
    players.alive.each(&:commit_suicide)
    players.each { |p| p.update!(player_name: (username || 'Unknown deadie')) unless p.player_name }
  end
end
