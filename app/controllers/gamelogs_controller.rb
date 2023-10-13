class GamelogsController < ApplicationController
    def new
        @gamelog = Gamelog.new
    end

    def create
        @gamelog = Gamelog.new(gamelog_params)
        if @gamelog.save
            redirect_to @gamelog
        else
            render 'new'
        end
    end

    def show
        @gamelog = Gamelog.find(params[:id])
    end

    def index
        @gamelogs = Gamelog.all
    end

    def edit
        @gamelog = Gamelog.find(params[:id])
    end

    def update
        @gamelog = Gamelog.find(params[:id])
    end

    private
    def gamelog_params
        params.require(:gamelog).permit(:player_id, :irlgame_id, :goals, :assists, :shots, :shots_on_goal, :fouls, :offsides, :yellow_cards, :red_cards, :saves, :passes, :passes_completed, :tackles, :interceptions, :blocks, :clearances, :minutes_played)
    end
    
end
