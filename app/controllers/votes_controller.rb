class VotesController < ApplicationController

  # POST /votes
  # POST /votes.json
  def create
    klout_score = current_user.klout_score
    @vote       = Vote.new(params[:vote].merge(
                             :user  => current_user,
                             :value => klout_score
                           ))
    @vote.save!

    repo          = @vote.repo
    repo.vote_sum += klout_score
    repo.save!

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { render action: "new" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end
end
