class GamesController < ApplicationController
  autocomplete :game, :name, :full => true
end
