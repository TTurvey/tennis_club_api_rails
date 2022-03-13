class Match < ApplicationRecord
  after_save :results
  belongs_to :winner, :class_name => 'Player'
  belongs_to :loser, :class_name => 'Player'

  def results
    points_exchanged = (loser.points.to_i * 0.1).floor

    ActiveRecord::Base.connection.execute(
      "UPDATE matches
      SET winner_points = #{winner.points}, loser_points = #{loser.points}, points_exchanged = #{points_exchanged}
      WHERE id = '#{id}'"
    )
    
    winner_updated_points = winner.points + points_exchanged
    loser_updated_points = loser.points - points_exchanged

    ActiveRecord::Base.connection.execute("UPDATE players SET points = #{winner_updated_points} WHERE id = '#{winner.id}'")
    ActiveRecord::Base.connection.execute("UPDATE players SET points = #{loser_updated_points} WHERE id = '#{loser.id}'")

    Player.update_game_count(player_id: winner.id)
    Player.update_game_count(player_id: loser.id)

    Player.update_rank_name(player_id: winner.id)
    Player.update_rank_name(player_id: loser.id)
  end
end
