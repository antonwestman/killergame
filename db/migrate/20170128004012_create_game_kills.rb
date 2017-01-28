class CreateGameKills < ActiveRecord::Migration[5.0]
  def change
    create_table :game_kills do |t|

      t.belongs_to :killer, null: false, foreign_key: { to_table: :game_players }
      t.belongs_to :victim, null: false, foreign_key: { to_table: :game_players }
      t.belongs_to :round, null: false, foreign_key: { to_table: :game_rounds }

      t.timestamps
    end
  end
end
