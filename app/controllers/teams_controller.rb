class TeamsController < ApplicationController
  before_action :ensure_user, only: [:new, :create]
  before_action do
    @game = Game.find(params[:game_id])
  end

  def new
    @team = @game.teams.new
  end

  def create
    @team = @game.teams.new(team_params)
    @team.user_id = current_user.id
    @team.next_draft
    if @team.save
      redirect_to root_path, notice: "You have successfully joined #{@game.name}!"
    else
      render :new
    end
  end

  def show
    @team = @game.teams.find(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

end
