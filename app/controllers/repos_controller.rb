class ReposController < ApplicationController

  def index
    @winners = 3.times.map do |i|
      offset = i + 1
      query = Repo.where(week_start: offset.weeks.ago.beginning_of_week).order("vote_sum DESC").limit(1)
      query.first
    end.compact

    @repos = Repo.where(week_start: Date.today.beginning_of_week).order("vote_sum DESC")
  end

  def create
    if Repo.find_by_name(params[:repo][:name]).present?
      return render json: { message: "GitHub repository has already been nominated."}, status: :conflict
    end

    begin
      Octokit.repo(params[:repo][:name])
    rescue Octokit::NotFound
      return render json: { message: "No GitHub repository found with that name." }, status: :conflict
    end

    klout_score = current_user.klout_score

    repo = Repo.create!(params[:repo].merge(
      week_start: Date.today.beginning_of_week,
      vote_sum: klout_score,
    ))

    Vote.create!(repo: repo, user: current_user, value: klout_score)

    repo.reload

    respond_with repo, status: :created
  end
end
