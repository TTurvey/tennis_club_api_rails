require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player1 = players(:one)
  end

  test "should get index" do
    get players_url, as: :json
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post players_url, params: { player: { first_name: 'Leeroy', last_name: 'Jenkins', nationality: @player1.nationality, date_of_birth: @player1.date_of_birth } }, as: :json
    end

    assert_response 201
  end

  test "should show player" do
    get player_url(@player1), as: :json
    assert_response :success
  end

  test "should update player" do
    patch player_url(@player1), params: { player: { first_name: @player1.first_name } }, as: :json
    assert_response 200
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete player_url(@player1), as: :json
    end

    assert_response 204
  end
end
