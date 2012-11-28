class WinnersController < ApplicationController
  respond_to :json

  def index
    respond_with Repo.recent_winners
  end
end
