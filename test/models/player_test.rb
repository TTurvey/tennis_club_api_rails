require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  
  setup do
    @player1 = players(:one)
    @player2 = players(:two)
    @match1 = matches(:one)
    @match2 = matches(:two)
  end

  test 'is valid with all required player params and unique full name' do
    player3 = Player.new(first_name: 'Leeroy', last_name: 'Jenkins', nationality: "Swiss", date_of_birth: "01/01/2000")
    assert player3.valid?, 'player is invalid without required params and unique full name'
  end

  test 'is invalid without first_name' do
    player3 = Player.new(last_name: 'Jenkins', nationality: "Swiss", date_of_birth: "01/01/2000")
    assert player3.invalid?, 'player is invalid without a first name'
  end

  test 'is invalid without last_name' do
    player3 = Player.new(first_name: 'Leeroy', nationality: "Swiss", date_of_birth: "01/01/2000")
    assert player3.invalid?, 'player is invalid without a last name'
  end

  test 'is invalid without nationality' do
    player3 = Player.new(first_name: 'Leeroy', last_name: 'Jenkins', date_of_birth: "01/01/2000")
    assert player3.invalid?, 'player is invalid without a nationality'
  end

  test 'is invalid without date of birth' do
    player3 = Player.new(first_name: 'Leeroy', last_name: 'Jenkins', nationality: "Swiss")
    assert player3.invalid?, 'player is invalid without a date of birth'
  end
  
  test 'is invalid when younger than 16 years old' do
    skip("test environment doesn't populate the test database tables. TBC")

    player3_dob = (Date.today - 15.years)
    player3 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "#{player3_dob}").save
    assert player3.invalid?, 'player is invalid without a last name'

    player4_dob = (Date.today - 16.years + 1.day)
    player4 = Player.create(first_name: "B", last_name: "B", nationality: "British", date_of_birth: "#{player4_dob}").save
    assert player4.invalid?, 'player is invalid without a last name'
  end

  test 'is valid when 16 years old or older' do
    skip("test environment doesn't populate the test database tables. TBC")

    player3_dob = (Date.today - 16.years)
    player3 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "#{player3_dob}").save
    assert player3.valid?, 'player is valid when 16years old or older'

    player4_dob = (Date.today - 30.years)
    player4 = Player.create(first_name: "B", last_name: "B", nationality: "British", date_of_birth: "#{player4_dob}")
    assert player4.valid?, 'player is valid when 16years old or older'
  end
  
  test 'has not played a game yet' do
    skip("test environment doesn't populate the test database tables. TBC")

    player3 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "01/01/2000").save
    assert_equal player3.match_count, 0
  end

  test 'has played one game' do
    skip("test environment doesn't populate the test database tables. TBC")

    @player3 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "01/01/2000").save
    player4 = Player.create(first_name: "B", last_name: "B", nationality: "British", date_of_birth: "01/01/2000").save
    match4 = Match.create(winner_id: 3, loser_id: 4).save
    assert_equal @player3, 1
  end

  test 'has points updated after match is played' do
    skip("test environment doesn't populate the test database tables. TBC")

    @player3 = Player.create(first_name: "A", last_name: "A", nationality: "British", date_of_birth: "01/01/2000").save
    player4 = Player.create(first_name: "B", last_name: "B", nationality: "British", date_of_birth: "01/01/2000").save
    match4 = Match.create(winner_id: 3, loser_id: 4).save
    assert_equal @player3, 1
  end

end
