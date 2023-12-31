class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.wins = 0
    @team.losses = 0
    @team.draws = 0
    if Team.last == nil
      @team.id = 1
    else
      @team.id = Team.last.id + 1
    end

    if @team.save
      redirect_to @team
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])

    if @team.update(team_params)
      redirect_to @team
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def team_params
    params.require(:team).permit(:name, :manager)
  end
end