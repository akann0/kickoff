require "selenium-webdriver"
require_relative "../helpers/irlgames_helper.rb"

class IrlgamesController < ApplicationController
include IrlgamesHelper
    def index
        @irlgames = Irlgame.all
    end

    def show
        @irlgame = Irlgame.find(params[:id])
    end

    def new
        @irlgame = Irlgame.new
    end

    def create
        @irlgame = Irlgame.new(irlgame_params)
        puts "got here"
        #do the id thing based on last
        if Irlgame.last == nil
            @irlgame.id = 1
        else
            @irlgame.id = Irlgame.last.id + 1
        end
        
        @irlgame.irlleague_id = 1 #temporary
        # @irlgame.status = "scheduled"
        # @irlgame.gamestart = DateTime.new(2020, 11, 21, 12, 30, 0, 0)
        # @irlgame.home = "aston-villa"
        # @irlgame.away = "brighton-hove-albion"

        


        p @irlgame

        if @irlgame.save
            puts "saved"
            redirect_to @irlgame
            
        else
            puts "not saved"
            @irlgame.errors.full_messages.each do |message|
                puts "ERROR", message
            end
            stop
            render :new, status: :unprocessable_entity
        end

        get_stats(@irlgame.url, @irlgame.id)
    end

    def edit
        @irlgame = Irlgame.find(params[:id])
    end

    def update
        @irlgame = Irlgame.find(params[:id])

        if @irlgame.update(irlgame_params)
            redirect_to @irlgame
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @irlgame = Irlgame.find(params[:id])
        @irlgame.destroy

        redirect_to root_path, status: :see_other
    end

    private
    def irlgame_params
        params.require(:irlgame).permit(:home, :away, :status, :gamestart, :url)
    end
end
