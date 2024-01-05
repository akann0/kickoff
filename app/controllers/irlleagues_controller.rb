require "selenium-webdriver"
require_relative "../helpers/players_helper.rb"
require_relative "../helpers/irlleagues_helper.rb"
require "i18n"


class IrlleaguesController < ApplicationController
    def index
        @irlleagues = Irlleague.all
    end

    def teams_show
        @irlleague = Irlleague.find(params[:id])
        @players = Player.where(irlleague_id: @irlleague.id)
    end

    def new 
        @irlleague = Irlleague.new
    end

    def edit
        @irlleague = Irlleague.find(params[:id])
    end

    def update
        @irlleague = Irlleague.find(params[:id])
    end

    def create
        @irlleague = Irlleague.new(irlleague_params)
        @irlleague.teamurls = ""

        if @irlleague.save
            redirect_to @irlleague
        else
            render :new, status: :unprocessable_entity
        end

        @irlleague.players = []
        
        # get the teams
        teams = get_team_urls(@irlleague.id, @irlleague.url)

        player_urls = []
        for team in teams
            #append the team urls to teamurls, followed by newline (delim)
            @irlleague.teamurls += team + "\n"
            gen_players(team)
        end
        @irlleague.save
    end

    private
    def irlleague_params
        params.require(:irlleague).permit(:name, :url)
    end

    def get_team_urls (id, url)
        standings_class = "eKizDL"
        hamburg = "https://www.sofascore.com/team/football/hamburger-sv/2676"
        # get the teams
        driver = Selenium::WebDriver.for :chrome
        driver.get url
        get_games(id, driver)
        standings = driver.find_elements(:class, standings_class)
        p standings
        team_elements = standings[0].find_elements(:xpath, "//a")
        # p "team elements, ", team_elements  
        teams = []
        team_ids = []
        for team in team_elements
            #check whether the string team is in the href        
            if team.attribute("href") != nil && team.attribute("href").include?("team") 
                #also check to make sure im not putting dupliates into teams
                if !team_ids.include?(team.attribute("href").split("/")[-1]) and team.attribute("href") != hamburg
                    teams.push(team.attribute("href"))
                    team_ids.push(team.attribute("href").split("/")[-1])
                end
            end
        end
        driver.close
        p "teams", teams, teams.length
        return teams
    end

    def get_games(id, driver)
        # get the games
        previous_button_class = "dbpbvb"
        games_class = "lhngCo"

        game_urls = []

        # click the previous button until it disappears
        previous_button = driver.find_elements(:class, previous_button_class)
        #bring back the previous code checking the elements in said class
        p "previous button"
        for button in previous_button
            p button.text
        end


        while previous_button[0].text == "PREVIOUS"
            p "clicking previous"
            previous_button[0].click
            previous_button = driver.find_elements(:class, previous_button_class)
    
            # pause for a half a second
            sleep(rand(0.2..0.4))
        end

        next_button = previous_button[0]
        
        while next_button.text == "NEXT"
            games = driver.find_elements(:class, games_class)
            for game in games
                game_urls.push(game.attribute("href"))
            end
            next_button.click
            p "clicking next"
            next_button = driver.find_elements(:class, previous_button_class)
            for button in next_button
                p button.text
            end
            if next_button.length == 1
                break
            else 
                next_button = next_button[1]
            end
            # pause for a half a second
            sleep(rand(0.2..0.4))
        end
        p "game urls", game_urls
    end

    # NOT USED
    def get_player_urls (url)
        driver = Selenium::WebDriver.for :chrome
        driver.get url

        links = driver.find_elements(:xpath, "//a")
        player_urls = []
        for link in links
            if link.attribute("href") != nil && link.attribute("href").include?("player")
                if !player_urls.include?(link.attribute("href"))
                    player_urls.push(link.attribute("href"))
                end
            end
        end
        # driver.close
        p "plyer urls", player_urls
        return player_urls
    
    end

    def gen_players(team_url)
        players_class = "iBlGhx"
        players_class_index = 4

        # open the website
        driver = Selenium::WebDriver.for :chrome
        driver.navigate.to team_url

        # find the players
        possibly_players = driver.find_elements(:class, players_class)
        # p "possibly players", possibly_players

        # for player in possibly_players
        #     p "player", player.text
        # end

        # split text block by newline
        split = possibly_players[players_class_index].text.split("\n")
        p "split", split

        #find all the links in this element - this is not used now
        # links = possibly_players[players_class_index].find_elements(:xpath, "//a")

        #iterate through split, but by the numbers
        player_count = 0
        for i in 0..split.length-1
            valid_positions = ["G", "M", "D", "F"]
            # if the string is in the array, then the line above it is a player name
            if split[i] != nil && valid_positions.include?(split[i])
                # create a player
                @player = Player.new
                @player.sofaid = rand(100000000)
                #TODO: add sofaid - this code is not working
                # @player.sofaid = links[player_count].attribute("href").split("/")[-1]
                player_count += 1
                @player.name = I18n.transliterate(split[i-1])
                @player.irlleague = @irlleague
                @player.team_id = rand(5) + 1
                @player.position = split[i]
                # @player, "player to be saved"
                if @player.save
                    puts "saved"
                else
                    puts "There was an error"
                    puts @player
                    puts @player.errors.full_messages
                end
            end
        end
        driver.quit
    end

    # NOT USED  
    def get_position (url)
        p "getting position"
        answer = ""
        # open the website
        driver = Selenium::WebDriver.for :chrome
        driver.navigate.to url
        # find the position
        #possibly_position = driver.find_elements(:xpath, "//div[@class='hjyjyy']")
        possibly_position = driver.find_elements(:class, "hjyjyy")
        # print the size of the position array
        for position in possibly_position
            puts position.text
            choices = ["G", "M", "D", "F"]
            # IF the position is in the choices array
            if choices.include? position.text
                answer = position.text
                break
            end
        end
        # close the website
        driver.quit
        return answer
    end
        
end
