class CreateGameRound
  def self.call(users:)
    new(users: users).call
  end

  def initialize(users:)
    @users = users
    @round = Game::Round.new
  end

  def call
    ActiveRecord::Base.transaction do
      players = @users.map { |u| Game::Player.new(user: u) }
      @round.players << players
      @round.save

      shuffled_players = players.shuffle
      shuffled_players.each.with_index do |player, index|
        Game::Mission.create(
          player: player,
          target: shuffled_players[(index + 1) % shuffled_players.count],
          place: Place.all.sample,
          weapon: Weapon.all.sample
        )
      end
      @round.save!
      raise 'This is not Soliraire. At least two players are required' if @round.players.count < 2
    end

    send_mission_instructions if @round.persisted?

    @round
  end

  private

  def send_mission_instructions
    @round.players.each do |player|
      Game::PlayerNotifierMailer.send_mission_instructions(player).deliver_later
    end
  end
end
