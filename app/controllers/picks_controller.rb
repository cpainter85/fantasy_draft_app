class PicksController < ApplicationController
  before_action do
    @team = Team.find(params[:team_id])
    @game = Game.find(params[:game_id])
  end
  before_action :ensure_team_belongs_to_current_user
  before_action :ensure_team_belongs_to_game

  def new
    @pick = @team.picks.new
  end

  def create
    @pick = @team.picks.new(pick_params)
    @pick.round_drafted = @team.picks.count+1
    if @pick.save
      redirect_to game_path(@game), notice: "#{@team.name} successfully drafted #{@pick.name}!"
    else
      render :new
    end
  end

  private

  def pick_params
    params.require(:pick).permit(:name, :from, :position_id)
  end

end
