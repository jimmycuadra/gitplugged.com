class VotesController < ApplicationController
  respond_to :json

  def create
    vote = Vote.for_repo_by_user(params[:vote].delete(:repo_name), current_user)

    if vote.save
      respond_with vote.repo, status: :created
    else
      respond_with vote.errors, status: :unprocessable_entity
    end
  end
end
