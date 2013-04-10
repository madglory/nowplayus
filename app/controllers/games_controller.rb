class GamesController < ApplicationController
  skip_before_filter :require_login

  def index
    @title = 'Games'
    per_page = params[:per_page] || 10
    if params[:q]
      @games = Game.select("id,slug,name,icon_url,deck").where("name ilike ?", "%#{params[:q]}%")
    else
      @games = Game.select("id,slug,name,icon_url,deck").order('name ASC')
    end

    @games = @games.paginate page: params[:page], per_page: params[:per_page]

    respond_to do |format|
      format.html
      format.json { render json: { total: @games.size, games: @games } }
    end
  end

  def show
    @game = Game.find params[:id]
    @title = @game.name
    @upcoming_events = @game.events.future
  end
end