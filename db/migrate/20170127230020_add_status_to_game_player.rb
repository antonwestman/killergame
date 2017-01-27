class AddStatusToGamePlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :game_players, :status, :string, null: false, default: 'alive'
  end
end
