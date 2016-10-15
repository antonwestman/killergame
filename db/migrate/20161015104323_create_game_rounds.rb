class CreateGameRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :game_rounds, &:timestamps
  end
end
