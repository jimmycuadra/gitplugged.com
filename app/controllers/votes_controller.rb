class VotesController < ApplicationController
  respond_to :json

  def create
    head :unauthorized and return unless current_user

    vote = Repo.find(params[:repo_id]).votes.create(user: current_user, value: current_user.score)

    respond_with vote.repo, status: :created, location: nil
  end
end
