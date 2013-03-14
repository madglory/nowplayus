class GamesController < ApplicationController
  skip_before_filter :require_login

  def index
    per_page = params[:per_page] || 10
    if params[:q]
      games = Game.select("id,name,icon_url,deck").where("name ilike ?", "%#{params[:q]}%")
    else
      games = Game.select("id,name,icon_url,deck").order('name ASC')
    end

    results = games.paginate page: params[:page], per_page: params[:per_page]

    respond_to do |format|
      format.json { render json: { total: results.size, games: results } }
    end
  end

  def show
    @game = Game.find params[:id]
    @upcoming_events = @game.events.future
  end
end