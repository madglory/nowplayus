class GamesController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show]

  autocomplete :game, :name, :full => true

  def index
    @games = Game.paginate(:page => params[:page]).order('name ASC')
  end

  def show
    @game = Game.find params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.ics  # show.ics.erb
      format.json { render json: @game }
    end
  end

end