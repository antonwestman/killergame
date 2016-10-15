class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|

      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
