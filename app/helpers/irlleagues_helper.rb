module IrlleaguesHelper
    def get_games(id, driver)
        # get the games
        games_class = "lhngCo"

        games = driver.find_elements(:class, games_class)

        game_urls = []
        for game in games
            game_urls.push(game.attribute("href"))
        end

        p "game urls", game_urls
    end
end
