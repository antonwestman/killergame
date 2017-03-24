class AddColumnNameToGameRound < ActiveRecord::Migration[5.0]
  def change
    add_column :game_rounds, :name, :string
  end
end
