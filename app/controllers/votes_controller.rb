class VotesController < ApplicationController
  respond_to :json

  def create
    klout_score = current_user.klout_score

    repo = Repo.find_by_name(params[:vote].delete(:repo_name))

    vote = Vote.new(params[:vote].merge(
      repo: repo,
      user: current_user,
      value: klout_score,
    ))

    if vote.save
      repo.vote_sum += klout_score
      repo.save!

      respond_with repo, status: :created
    else
      respond_with vote.errors, status: :unprocessable_entity
    end
  end
end
