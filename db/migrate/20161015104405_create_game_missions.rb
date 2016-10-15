class CreateGameMissions < ActiveRecord::Migration[5.0]
  def change
    create_table :game_missions do |t|
      t.belongs_to :player, null: false, foreign_key: { to_table: :game_players }
      t.belongs_to :target, null: false, foreign_key: { to_table: :game_players }
      t.belongs_to :place, foreign_key: true, null: false
      t.belongs_to :weapon, foreign_key: true, null: false

      t.timestamps
    end
  end
end
