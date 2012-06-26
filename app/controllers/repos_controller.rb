class ReposController < ApplicationController
  def index
    @winners = Repo.recent_winners
    @repos = Repo.in_the_running
  end

  def create
    begin
      respond_with Repo.nominate(params[:repo], current_user)
    rescue Repo::AlreadyNominated
      render json: { message: "GitHub repository has already been nominated." }, status: :conflict
    rescue Repo::NotFound
      render json: { message: "No GitHub repository found with that name." }, status: :conflict
    end
  end
end
