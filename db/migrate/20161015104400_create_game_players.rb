class CreateGamePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :game_players do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :round, foreign_key: { to_table: :game_rounds }
      t.string :player_name

      t.timestamps
    end
  end
end
