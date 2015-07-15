class GamesController < ApplicationController
  def new
    @game = Game.new
    @team = @game.teams.new
  end

  def create
    @game = Game.new(game_params)
    @team = @game.teams.new(team_params)
    @team.draft_order = 1
    @team.user_id = current_user.id

    if @game.save && @team.save
      redirect_to root_path, notice: "#{@game.name} successfully created!"
    else
      render :new
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :description)
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
