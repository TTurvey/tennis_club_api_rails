class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]

  # GET /players
  def index
    @players = Player.all 
    # (:order => rank_name: DESC, points: DESC, )

    [:nationality, :rank_name].each do |filter|
      players = players.send(filter, params[filter]) if params[filter]
    end

    filtering_params(params).each do |key, value|
      @players = @players.public_send("filter_by_#{key}", value) if value.present?
    end

    render json: @players
  end

  # GET /players/1
  def show
    render json: @players
  end

  # POST /players
  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player, status: :created, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # A list of the param names that can be used for filtering the Product list
    def filtering_params(params)
      params.slice(:nationality, :rank_name)
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:first_name, :last_name, :nationality, :date_of_birth)
    end
end
