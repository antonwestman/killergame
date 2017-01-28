class AddOngoingToGameRound < ActiveRecord::Migration[5.0]
  def change
    add_column :game_rounds, :ongoing, :boolean, default: true
  end
end
