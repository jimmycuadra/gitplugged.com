class ReposController < ApplicationController
  # GET /repos
  # GET /repos.json
  def index
    @repos = Repo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repos }
    end
  end

  # GET /repos/1
  # GET /repos/1.json
  def show
    @repo = Repo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repo }
    end
  end

  # GET /repos/new
  # GET /repos/new.json
  def new
    @repo = Repo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repo }
    end
  end

  # GET /repos/1/edit
  def edit
    @repo = Repo.find(params[:id])
  end

  # POST /repos
  # POST /repos.json
  def create
    return head :unprocessable_entity if Repo.find_by_name(params[:repo][:name]).present?

    begin
      Octokit.repo(params[:repo][:name])
    rescue Octokit::NotFound => e
      return head :unprocessable_entity
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
=begin
      else
        format.html { render action: "new" }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
=end
    end
  end

  # PUT /repos/1
  # PUT /repos/1.json
  def update
    @repo = Repo.find(params[:id])

    respond_to do |format|
      if @repo.update_attributes(params[:repo])
        format.html { redirect_to @repo, notice: 'Repo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repos/1
  # DELETE /repos/1.json
  def destroy
    @repo = Repo.find(params[:id])
    @repo.destroy

    respond_to do |format|
      format.html { redirect_to repos_url }
      format.json { head :no_content }
    end
  end
end
