class ClansController < ApplicationController
  def index
    @clans = Clan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clans }
    end
  end

  def show
    @clan = Clan.find params[:id].downcase

    respond_to do |format|
      format.html # show.html.erb
      format.ics  # show.ics.erb
      format.json { render json: @clan }
    end
  end
end
