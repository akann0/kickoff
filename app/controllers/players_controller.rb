require "selenium-webdriver"
require_relative "../helpers/players_helper.rb"

class PlayersController < ApplicationController
    def index
        @players = Player.all
    end

    def create
        puts "Creating a player"
        p player_params
        @player = Player.new(player_params)
        @player.sofaid = player_params['sofaid']
        @player.name = player_params['name']
        @player.irlleague = player_params['irlleague']
        # set team id to a random number 1 through 5
        @player.team_id = rand(6)

        p @player
        p @player.name

        #turn all spaces in the name into dashes
        name_for_url = @player.name.gsub(/\s+/, "-")

        url = "https://www.sofascore.com/player/" + name_for_url + "/" + @player.sofaid

        # get the position
        @player.position = get_position(url)

        # @player.position = position.text
        # find the table

        if @player.save
            redirect_to @player
        else
            # print that there was an error
            puts "There was an error"
            render 'new'
        end
    end

    def show
        @player = Player.find(params[:id])
    end

    def new
        @player = Player.new
    end

    def edit
        @player = Player.find(params[:id])
    end

    def update
        @player = Player.find(params[:id])
    end

    private
    def player_params
        params.require(:player).permit(:name, :sofaid)
    end
end
