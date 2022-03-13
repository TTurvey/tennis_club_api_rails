require 'rails_helper'

RSpec.describe Player, type: :model do
  
  context 'is younger than 16 years old' do
    it 'cannot be created' do
      player1_dob = (Date.today - 15.years)
      player1 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "#{player1_dob}")
      expect(player1).to be_invalid
  
      player2_dob = (Date.today - 16.years + 1.day)
      player2 = Player.create(first_name: "B", last_name: "B", nationality: "British", date_of_birth: "#{player2_dob}")
      expect(player2).to be_invalid
    end
  end

  context 'is 16 years old or older' do
    it 'is valid' do
      player1_dob = (Date.today - 16.years)
      player1 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "#{player1_dob}")
      expect(player1).to be_valid

      player2_dob = (Date.today - 30.years)
      player2 = Player.create(first_name: "B", last_name: "B", nationality: "British", date_of_birth: "#{player2_dob}")
      expect(player2).to be_valid
    end
  end

  context 'has not played a game yet' do
    it 'matches played is zero' do
      player1 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "01/01/2000")
      expect(player1.match_count).to eq(0)
    end
  end

  xcontext 'has played one match' do 
    it 'matches played is one' do
      player1 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "01/01/2000").save
      player2 = Player.create(first_name: "B", last_name: "B", nationality: "British", date_of_birth: "01/01/2001").save
      match1 = Match.create(winner_id: 1, loser_id: 2).save
      # match1.results
      # Player.find_by_id(id:1)
      expect(Player.find(1).match_count).to eq(1)
      expect(player2.match_count).to eq(1)
    end
  
    it 'points change by 10% of the losers points' do
      player1 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "01/01/2000").save
      player2 = Player.create(first_name: "B", last_name: "B", nationality: "British", date_of_birth: "01/01/2001")
      match1 = Match.create(winner_id: 1, loser_id: 2)
      # match1.results
      # player1 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "#{player1_dob}")
      # expect(player1).to be_invalid
      # player1.match_count
      # player2_dob = (Date.today - 16.years + 1.day)
      # player2 = Player.create(first_name: "B", last_name: "B", nationality: "British", date_of_birth: "#{player2_dob}")
      point_change = player2.points * 0.1
      
      expect(Player.find(first).points).to eq(player1.points + point_change)
    end
  end
end
