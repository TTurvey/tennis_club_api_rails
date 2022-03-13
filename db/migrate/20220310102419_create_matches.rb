class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.string :winner_id
      t.string :loser_id
      t.integer :winner_points
      t.integer :loser_points
      t.integer :points_exchanged
    end
  end
end
