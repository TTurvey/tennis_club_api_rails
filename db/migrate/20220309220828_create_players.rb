class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :nationality
      t.string :date_of_birth
      t.string :current_position
      t.integer :points
      t.string :rank_name
      t.integer :match_count

      t.timestamps
    end
    
    add_index :players, [ :first_name, :last_name ], :unique => true
  end
end
