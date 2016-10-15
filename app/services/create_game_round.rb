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
      players =  @users.map { |u| Game::Player.new(user: u) }

      shuffled_players = players.shuffle
      shuffled_players.each.with_index do |player, index|
        player.target = shuffled_players[(index+1)%shuffled_players.count]
        player.mission.place = Place.all.sample
        player.mission.weapon = Weapon.all.sample
      end      
      @round.players << players
      @round.save
    end

  end

end