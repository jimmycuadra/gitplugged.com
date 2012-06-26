class ReposController < ApplicationController
  respond_to :json

  def index
    @winners = Repo.recent_winners
    @repos = Repo.in_the_running

    respond_to { |format| format.html }
  end

  def create
    begin
      respond_with Repo.nominate(params[:repo], current_user), status: :created, location: nil
    rescue Repo::AlreadyNominated
      render json: { message: "GitHub repository has already been nominated." }, status: :conflict
    rescue Repo::NotFound
      render json: { message: "No GitHub repository found with that name." }, status: :unprocessable_entity
    end
  end
end
