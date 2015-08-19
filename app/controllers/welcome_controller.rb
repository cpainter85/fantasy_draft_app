class WelcomeController < ApplicationController
  def index
    @games = Game.includes(:teams).all
  end
end
