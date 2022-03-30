class Player < ApplicationRecord
  has_many :matches
  after_initialize :set_defaults, unless: :persisted?

  validates_presence_of :first_name, :last_name, :nationality, :date_of_birth
  validate :age_restriction

  scope :filter_by_nationality, -> (nationality) { where(nationality: nationality) }
  scope :filter_by_rank_name, -> (rank_name) { where(rank_name: rank_name) }

  DEFAULT_POINTS = 1200

  def set_defaults
    self.points = DEFAULT_POINTS
    self.rank_name = 'Unranked'
    self.match_count = 0
  end

  # assuming dob format is dd/mm/yy
  def age_restriction
    if date_of_birth.present?
      if !((date_of_birth.to_date + 16.years) <= Date.today)
        errors.add :date_of_birth, 'Player must be at least 16 years old.'
      end
    end
  end

  def self.update_game_count(player_id:)
    players_matches = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM matches WHERE winner_id = '#{player_id}' OR loser_id = '#{player_id}'")
    game_count = players_matches[0]['count']
    ActiveRecord::Base.connection.execute("UPDATE players SET match_count = #{game_count} WHERE id = '#{player_id}'")
  end

  def self.update_rank_name(player_id:)
    player = ActiveRecord::Base.connection.execute("SELECT * FROM players WHERE id = '#{player_id}'")

    # rank_name won't change from 'Unranked' until match_count is 3 or more.
    if player[0]['match_count'] < 3
      ActiveRecord::Base.connection.execute("UPDATE players SET rank_name = 'Unranked' WHERE id = '#{player_id}'")
    elsif player[0]['points'].between?(0, 2999)
      ActiveRecord::Base.connection.execute("UPDATE players SET rank_name = 'Bronze' WHERE id = '#{player_id}'")
    elsif player[0]['points'].between?(3000, 4999)
      ActiveRecord::Base.connection.execute("UPDATE players SET rank_name = 'Silver' WHERE id = '#{player_id}'")
    elsif player[0]['points'].between?(5000, 9999)
      ActiveRecord::Base.connection.execute("UPDATE players SET rank_name = 'Gold' WHERE id = '#{player_id}'")
    elsif player[0]['points'] >= 10000
      ActiveRecord::Base.connection.execute("UPDATE players SET rank_name = 'Supersonic Legend' WHERE id = '#{player_id}'")
    end
  end

  def self.update_current_positions
    ranked_players = ActiveRecord::Base.connection.execute("SELECT * FROM players WHERE NOT rank_name = 'Unranked'")
    ranked_players.each do |player|
      new_position = Player.where("points > ?", player['points']).where.not(rank_name: 'Unranked').count + 1
      ActiveRecord::Base.connection.execute("UPDATE players SET current_position = '#{new_position}' WHERE id = '#{player['id']}'")
    end
  end
end
