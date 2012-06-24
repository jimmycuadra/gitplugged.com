class ReposController < ApplicationController

  def index
    @winners = 3.times.map do |i|
      offset     = i + 1
      week_start = offset.weeks.ago.beginning_of_week
      (Repo.where(:week_start => week_start).order("vote_sum DESC").limit(1)).first
    end.compact

    @repos = Repo.where(:week_start => Date.today.beginning_of_week).order("vote_sum DESC")
  end

  def create
    return render json: {message: "Duplicate repo"}, status: :conflict if Repo.find_by_name(params[:repo][:name]).present?

    begin
      Octokit.repo(params[:repo][:name])
    rescue Octokit::NotFound => e
      return render json: {message: "GitHub repository doesn't exist"}, status: :conflict
    end

    klout_score_of_user = current_user.klout_score

    @repo = Repo.new(params[:repo].merge(
                       :week_start => Date.today.beginning_of_week,
                       :vote_sum   => klout_score_of_user
                     ))
    @repo.save!
    @vote = Vote.new(:repo => @repo, :user => current_user, :value => klout_score_of_user)
    @vote.save!


    respond_to do |format|
      format.html { redirect_to @repo, notice: 'Repo was successfully created.' }
      format.json { render json: @repo, status: :created, location: @repo }
    end
  end
end
