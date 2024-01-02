require "selenium-webdriver"
require "i18n"





module IrlgamesHelper
    def get_stats (url, id)
        @irlgame = Irlgame.find(id)
        final_score_class = "lgCNjw"
        team_names_class = "ewXNuL"
        player_stats_categories_buttons_class = "eCGFOL"
        player_stats_button_class = "LYUxR"
        player_stats_table_class = "eelAoB"
        ss_rating_header = "Sofascore rating"
        
        p "gettin game stats"
        # open the website
        driver = Selenium::WebDriver.for :chrome
        # i need to let the code run after a certain point even if the website is not fully loaded
        driver.manage.timeouts.implicit_wait = 12
        driver.manage.timeouts.page_load = 12
        

        #try loop
        begin
            driver.get url
        rescue
            puts "rescued"
        end
        p "opened website"
    
        # the goal is to find the two teams who are playing in this game
        possibly = driver.find_elements(:class, team_names_class)
        # if (possibly.length > 1)
        #     puts possibly.length, "MULTIPLE THINGS THAT COULD BE THE TEAMS"
        # end
        # puts "possibly", possibly[0].text.split("-")[0][0..-2], possibly[0].text.split("-")[1][1..-1]
        @irlgame.home = possibly[0].text.split("-")[0][0..-2]
        @irlgame.away = possibly[0].text.split("-")[1][1..-1]


        # the goal is to find the final score
        possibly = driver.find_elements(:class, final_score_class)
        # if (possibly.length > 1)
        #     puts possibly.length, "MULTIPLE THINGS THAT COULD BE THE FINAL SCORE"
        # end
        @irlgame.home_score = possibly[0].text.split(" ")[0]
        @irlgame.away_score = possibly[0].text.split(" ")[2]


        possibly = driver.find_elements(:class, player_stats_button_class)
        # puts "possibly player statistics length", possibly.length
        for possible in possibly
            # puts possible.text
            if possible.text.include? "PLAYER STATISTICS"
                possible.click
            end
        end

        table = driver.find_elements(:class, player_stats_table_class)
        # puts "table text", table[0].text
        table_array = table[0].text.split("\n")
        puts "table array", table_array
        table_headers = table_array[0..table_array.index(ss_rating_header)]
        puts "table headers", table_headers
        gamelogs = Hash.new
        i = table_headers.length

        while table_array.length >= table_headers.length + i
            partial_gamelog = Hash.new
            for header in table_headers
                partial_gamelog["team"] = @irlgame.away
                if header == "+"
                    #transliterate names so that they don't have accents
                    partial_gamelog["+"] = I18n.transliterate(table_array[i])
                else
                    partial_gamelog[header] = table_array[i]
                end
                i += 1
            end
            gamelogs[partial_gamelog["+"]] = [partial_gamelog]
        end

        #click the button that shows only the home team players
        possibly = driver.find_elements(:class, player_stats_button_class)

        puts "gamelogs one", gamelogs
        # now, iterate through the table_array

        # now, the goal is to iterate through all the buttons that show different stats
        for cat in ["Attack", "Defence", "Passing", "Duels", "Goalkeeper"]
            # reveal the correct table
            buttons = driver.find_elements(:class, player_stats_categories_buttons_class)
            for button in buttons
                if button.text == cat
                    button.click
                end
            end

            # find the table
            table = driver.find_elements(:class, player_stats_table_class)
            table_array = table[0].text.split("\n")
            table_headers = table_array[0..table_array.index(ss_rating_header)]
            i = table_headers.length

            while table_array.length >= table_headers.length + i
                partial_gamelog = Hash.new
                for header in table_headers
                    partial_gamelog[header] = table_array[i]
                    # oftentimes there are multiple notes seperated by a newline
                    if header == "Notes"
                        while table_array[i+1].length > 1 and table_array[i+1].include? " "
                            partial_gamelog[header] += ";" + table_array[i+1]
                            i += 1
                        end
                    end
                    i += 1
                end
                #add to a list inside the hash
                # puts gamelogs
                puts I18n.transliterate(partial_gamelog["+"])
                # puts "b"
                puts "if this is empty, we somehow messed up", gamelogs[I18n.transliterate(partial_gamelog["+"])]
                # append partial gamelog to the list gamelogs[I18n.transliterate(partial_gamelog["+"])]
                gamelogs[I18n.transliterate(partial_gamelog["+"])].append(partial_gamelog)
            end
            # puts cat + ": gamelogs", gamelogs
        end

        puts "gamelogs pt 2", gamelogs

        #"Nick Pope"=>[{"+"=>"Nick Pope", "Goals"=>"0", "Assists"=>"0", "Tackles"=>"0", "Accurate passes"=>"18/23 (78%)", "Duels (won)"=>"0 (0)", "Ground duels (won)"=>"0 (0)", "Aerial duels (won)"=>"0 (0)", "Minutes played"=>"90'", "Position"=>"G", "Average Sofascore rating"=>"6.0"}, 
        # {"+"=>"Nick Pope^", "Shots on target"=>"0", "Shots off target"=>"0", "Shots blocked"=>"0", "Dribble attempts (succ.)"=>"0 (0)", "Notes"=>"-", "Position"=>"G", "Average Sofascore rating"=>"6.0"}, 
        # {"+"=>"Nick Pope^", "Clearances"=>"1", "Blocked shots"=>"0", "Interceptions"=>"0", "Tackles"=>"0", "Dribbled past"=>"0", "Notes"=>"Error led to goal: 1", "Position"=>"G", "Average Sofascore rating"=>"6.0"}, 
        # {"+"=>"Nick Pope^", "Touches"=>"34", "Accurate passes"=>"18/23 (78%)", "Key passes"=>"0", "Crosses (acc.)"=>"0 (0)", "Long balls (acc.)"=>"8 (3)", "Notes"=>"-", "Position"=>"G", "Average Sofascore rating"=>"6.0"}, 
        # {"+"=>"Nick Pope^", "Ground duels (won)"=>"0 (0)", "Aerial duels (won)"=>"0 (0)", "Possession lost"=>"5", "Fouls"=>"0", "Was fouled"=>"0", "Offsides"=>"0", "Position"=>"G", "Average Sofascore rating"=>"6.0"}, 
        # {"+"=>"Nick Pope^", "Saves"=>"4", "Goals prevented"=>"-1.26", "Punches"=>"0", "Runs out (succ.)"=>"2 (2)", "High claims"=>"0", "Notes"=>"Saves from inside box: 2;Error led to goal: 1", "Average Sofascore rating"=>"6.0"}]}
        # NOTE that the key and the element + are not the same as + may have accent marks, as denoted by the ^
        for player in gamelogs.keys
            puts "player", player
            puts gamelogs[player]

            # create a gamelog
            @gamelog = Gamelog.new
            if Gamelog.last == nil
                @gamelog.id = 1
            else
                @gamelog.id = Gamelog.last.id + 1
            end
            # p player
            # p Player.find_by(name: player)
            # p Player.find_by(name: player).id
            if Player.find_by(name: player) == nil
                @gamelog.player_id = 1
            else
                @gamelog.player_id = Player.find_by(name: player).id
            end
            @gamelog.irlgame_id = id
            @gamelog.goals = gamelogs[player][0]["Goals"]
            @gamelog.assists = gamelogs[player][0]["Assists"]

            #ATTACKING STATS
            @gamelog.shots = gamelogs[player][1]["Shots on target"].to_i + gamelogs[player][1]["Shots off target"].to_i + gamelogs[player][1]["Shots blocked"].to_i
            @gamelog.shots_on_goal = gamelogs[player][1]["Shots on target"]
            @gamelog.dribbles = gamelogs[player][1]["Dribble attempts (succ.)"].split(")")[0].split("(")[1]
            @gamelog.dribbles_attempted = gamelogs[player][1]["Dribble attempts (succ.)"].split(" ")[0]

            #PASSING STATS
            @gamelog.passes_attempted = gamelogs[player][3]["Accurate passes"].split(" ")[0].split("/")[1]
            @gamelog.passes_completed = gamelogs[player][3]["Accurate passes"].split(" ")[0].split("/")[0]
            @gamelog.key_passes = gamelogs[player][3]["Key passes"]
            @gamelog.crosses = gamelogs[player][3]["Crosses (acc.)"].split(")")[0].split("(")[1]
            @gamelog.crosses_attempted = gamelogs[player][3]["Crosses (acc.)"].split(" ")[0]
            @gamelog.long_balls = gamelogs[player][3]["Long balls (acc.)"].split(")")[0].split("(")[1]
            @gamelog.long_balls_attempted = gamelogs[player][3]["Long balls (acc.)"].split(" ")[0]

            #DEFENSIVE STATS
            @gamelog.tackles = gamelogs[player][0]["Tackles"]
            @gamelog.interceptions = gamelogs[player][2]["Interceptions"]
            @gamelog.blocks = gamelogs[player][2]["Blocked shots"]
            @gamelog.clearances = gamelogs[player][2]["Clearances"]
            # check notes for error lead to shot, error led to goal, penalty committed
            @gamelog.error_lead_to_shot = 0
            @gamelog.error_lead_to_goal = 0
            @gamelog.penalty_committed = 0
            for note in gamelogs[player][2]["Notes"].split(";")
                if note.include? "Error led to shot"
                    @gamelog.error_lead_to_shot += 1
                elsif note.include? "Error led to goal"
                    @gamelog.error_lead_to_goal += 1
                elsif note.include? "Penalty committed"
                    @gamelog.penalty_committed += 1
                end
            end

            #DUELS STATS
            @gamelog.ground_duels_won = gamelogs[player][4]["Ground duels (won)"].split(")")[0].split("(")[1]
            @gamelog.ground_duels = gamelogs[player][4]["Ground duels (won)"].split(" ")[0]
            @gamelog.aerial_duels_won = gamelogs[player][4]["Aerial duels (won)"].split(")")[0].split("(")[1]
            @gamelog.aerial_duels = gamelogs[player][4]["Aerial duels (won)"].split(" ")[0]
            @gamelog.possession_lost = gamelogs[player][4]["Possession lost"]
            @gamelog.fouls = gamelogs[player][4]["Fouls"]
            @gamelog.was_fouled = gamelogs[player][4]["Was fouled"]
            @gamelog.offsides = gamelogs[player][4]["Offsides"]

            #GOALKEEPER STATS
            if gamelogs[player].length > 5
                @gamelog.saves = gamelogs[player][5]["Saves"]
                @gamelog.goals_prevented = gamelogs[player][5]["Goals prevented"]
            else 
                @gamelog.saves = 0
                @gamelog.goals_prevented = 0
            end

            @gamelog.minutes_played = gamelogs[player][0]["Minutes played"].split("'")[0]

            # p @gamelog

            if @gamelog.save
                puts "gamelog saved"
                # redirect_to @gamelog
            else
                puts "gamelog not saved"
                # render 'new'
                @irlgame.errors.full_messages.each do |message|
                    puts "ERROR", message
                end
            end
            @irlgame.save
        end
        # close the website
        driver.quit
    end
end


        # q: list all the stats added after assists
        # a: shots, shots on goal, dribbles, dribbles attempted, passes attempted, passes completed, key passes, crosses, crosses attempted, long balls, long balls attempted, tackles, interceptions, blocks, clearances, error lead to shot, error lead to goal, penalty committed, ground duels won, ground duels, aerial duels won, aerial duels, possession lost, fouls, was fouled, offsides, saves, goals prevented, minutes played
        # q: now format it in the following method
        # a: shots:integer shots_on_goal:integer dribbles:integer dribbles_attempted:integer passes_attempted:integer passes_completed:integer key_passes:integer crosses:integer crosses_attempted:integer long_balls:integer long_balls_attempted:integer tackles:integer interceptions:integer blocks:integer clearances:integer error_lead_to_shot:integer error_lead_to_goal:integer penalty_committed:integer ground_duels_won:integer ground_duels:integer aerial_duels_won:integer aerial_duels:integer possession_lost:integer fouls:integer was_fouled:integer offsides:integer saves:integer goals_prevented:integer minutes_played:integer


        # q: now format it in the following method
        # a: shots_and_shots_on_goal_and_dribbles_and_dribbles_attempted_and_passes_attempted_and_passes_completed_and_key_passes_and_crosses_and_crosses_attempted_and_long_balls_and_long_balls_attempted_and_tackles_and_interceptions_and_blocks_and_clearances_and_error_lead_to_shot_and_error_lead_to_goal_and_penalty_committed_and_ground_duels_won_and_ground_duels_and_aerial_duels_won_and_aerial_duels_and_possession_lost_and_fouls_and_was_fouled_and_offsides_and_saves_and_goals_prevented_and_minutes_played
        
        # ruby bin/rails g migration add_shots_and_shots_on_goal_and_dribbles_and_dribbles_attempted_and_passes_attempted_and_passes_completed_and_key_passes_and_crosses_and_crosses_attempted_and_long_balls_and_long_balls_attempted_and_tackles_and_interceptions_and_blocks_and_clearances_and_error_lead_to_shot_and_error_lead_to_goal_and_penalty_committed_and_ground_duels_won_and_ground_duels_and_aerial_duels_won_and_aerial_duels_and_possession_lost_and_fouls_and_was_fouled_and_offsides_and_saves_and_goals_prevented_and_minutes_played_to_irlgame shots:integer shots_on_goal:integer dribbles:integer dribbles_attempted:integer passes_attempted:integer passes_completed:integer key_passes:integer crosses:integer crosses_attempted:integer long_balls:integer long_balls_attempted:integer tackles:integer interceptions:integer blocks:integer clearances:integer error_lead_to_shot:integer error_lead_to_goal:integer penalty_committed:integer ground_duels_won:integer ground_duels:integer aerial_duels_won:integer aerial_duels:integer possession_lost:integer fouls:integer was_fouled:integer offsides:integer saves:integer goals_prevented:integer minutes_played:integer


        # now generate each of these as individual migrations as such
        # ruby bin/rails g migration addShotToIrlgame shots:integer
        # ruby bin/rails g migration addShots_on_goalToIrlgame shots_on_goal:integer
        # ruby bin/rails g migration addDribblesToIrlgame dribbles:integer
        # ruby bin/rails g migration addDribbles_attemptedToIrlgame dribbles_attempted:integer
        # ruby bin/rails g migration addPasses_attemptedToIrlgame passes_attempted:integer
        # ruby bin/rails g migration addPasses_completedToIrlgame passes_completed:integer
        # ruby bin/rails g migration addKey_passesToIrlgame key_passes:integer
        # ruby bin/rails g migration addCrossesToIrlgame crosses:integer
        # ruby bin/rails g migration addCrosses_attemptedToIrlgame crosses_attempted:integer
        # ruby bin/rails g migration addLong_ballsToIrlgame long_balls:integer
        # ruby bin/rails g migration addLong_balls_attemptedToIrlgame long_balls_attempted:integer
        # ruby bin/rails g migration addTacklesToIrlgame tackles:integer
        # ruby bin/rails g migration addInterceptionsToIrlgame interceptions:integer
        # ruby bin/rails g migration addBlocksToIrlgame blocks:integer
        # ruby bin/rails g migration addClearancesToIrlgame clearances:integer
        # ruby bin/rails g migration addError_lead_to_shotToIrlgame error_lead_to_shot:integer
        # ruby bin/rails g migration addError_lead_to_goalToIrlgame error_lead_to_goal:integer
        # ruby bin/rails g migration addPenalty_committedToIrlgame penalty_committed:integer
        # ruby bin/rails g migration addGround_duels_wonToIrlgame ground_duels_won:integer
        # ruby bin/rails g migration addGround_duelsToIrlgame ground_duels:integer
        # ruby bin/rails g migration addAerial_duels_wonToIrlgame aerial_duels_won:integer
        # ruby bin/rails g migration addAerial_duelsToIrlgame aerial_duels:integer
        # ruby bin/rails g migration addPossession_lostToIrlgame possession_lost:integer
        # ruby bin/rails g migration addFoulsToIrlgame fouls:integer
        # ruby bin/rails g migration addWas_fouledToIrlgame was_fouled:integer
        # ruby bin/rails g migration addOffsidesToIrlgame offsides:integer
        # ruby bin/rails g migration addSavesToIrlgame saves:integer
        # ruby bin/rails g migration addGoals_preventedToIrlgame goals_prevented:integer
        # ruby bin/rails g migration addMinutes_playedToIrlgame minutes_played:integer

        #Dumbass LMAO

        # ruby bin/rails g mirgration RemoveShotFromIrlgame shots:integer
        # ruby bin/rails g migration RemoveShots_on_goalFromIrlgame shots_on_goal:integer
        # ruby bin/rails g migration RemoveDribblesFromIrlgame dribbles:integer
        # ruby bin/rails g migration RemoveDribbles_attemptedFromIrlgame dribbles_attempted:integer
        # ruby bin/rails g migration RemovePasses_attemptedFromIrlgame passes_attempted:integer
        # ruby bin/rails g migration RemovePasses_completedFromIrlgame passes_completed:integer
        # ruby bin/rails g migration RemoveKey_passesFromIrlgame key_passes:integer
        # ruby bin/rails g migration RemoveCrossesFromIrlgame crosses:integer
        # ruby bin/rails g migration RemoveCrosses_attemptedFromIrlgame crosses_attempted:integer
        # ruby bin/rails g migration RemoveLong_ballsFromIrlgame long_balls:integer
        # ruby bin/rails g migration RemoveLong_balls_attemptedFromIrlgame long_balls_attempted:integer
        # ruby bin/rails g migration RemoveTacklesFromIrlgame tackles:integer
        # ruby bin/rails g migration RemoveInterceptionsFromIrlgame interceptions:integer
        # ruby bin/rails g migration RemoveBlocksFromIrlgame blocks:integer
        # ruby bin/rails g migration RemoveClearancesFromIrlgame clearances:integer
        # ruby bin/rails g migration RemoveError_lead_to_shotFromIrlgame error_lead_to_shot:integer
        # ruby bin/rails g migration RemoveError_lead_to_goalFromIrlgame error_lead_to_goal:integer
        # ruby bin/rails g migration RemovePenalty_committedFromIrlgame penalty_committed:integer
        # ruby bin/rails g migration RemoveGround_duels_wonFromIrlgame ground_duels_won:integer
        # ruby bin/rails g migration RemoveGround_duelsFromIrlgame ground_duels:integer
        # ruby bin/rails g migration RemoveAerial_duels_wonFromIrlgame aerial_duels_won:integer
        # ruby bin/rails g migration RemoveAerial_duelsFromIrlgame aerial_duels:integer
        # ruby bin/rails g migration RemovePossession_lostFromIrlgame possession_lost:integer
        # ruby bin/rails g migration RemoveFoulsFromIrlgame fouls:integer
        # ruby bin/rails g migration RemoveWas_fouledFromIrlgame was_fouled:integer
        # ruby bin/rails g migration RemoveOffsidesFromIrlgame offsides:integer
        # ruby bin/rails g migration RemoveSavesFromIrlgame saves:integer

        '''
        ruby bin/rails g migration addShotsToGamelog shots:integer
        & ruby bin/rails g migration addShots_on_goalToGamelog shots_on_goal:integer
        & ruby bin/rails g migration addDribblesToGamelog dribbles:integer
        & ruby bin/rails g migration addDribbles_attemptedToGamelog dribbles_attempted:integer
        & ruby bin/rails g migration addPasses_attemptedToGamelog passes_attempted:integer
        & ruby bin/rails g migration addPasses_completedToGamelog passes_completed:integer
        & ruby bin/rails g migration addKey_passesToGamelog key_passes:integer
        & ruby bin/rails g migration addCrossesToGamelog crosses:integer
        & ruby bin/rails g migration addCrosses_attemptedToGamelog crosses_attempted:integer
        & ruby bin/rails g migration addLong_ballsToGamelog long_balls:integer
        & ruby bin/rails g migration addLong_balls_attemptedToGamelog long_balls_attempted:integer
        & ruby bin/rails g migration addTacklesToGamelog tackles:integer
        & ruby bin/rails g migration addInterceptionsToGamelog interceptions:integer
        & ruby bin/rails g migration addBlocksToGamelog blocks:integer
        & ruby bin/rails g migration addClearancesToGamelog clearances:integer
        & ruby bin/rails g migration addError_lead_to_shotToGamelog error_lead_to_shot:integer
        & ruby bin/rails g migration addError_lead_to_goalToGamelog error_lead_to_goal:integer
        & ruby bin/rails g migration addPenalty_committedToGamelog penalty_committed:integer
        & ruby bin/rails g migration addGround_duels_wonToGamelog ground_duels_won:integer
        & ruby bin/rails g migration addGround_duelsToGamelog ground_duels:integer
        & ruby bin/rails g migration addAerial_duels_wonToGamelog aerial_duels_won:integer
        & ruby bin/rails g migration addAerial_duelsToGamelog aerial_duels:integer
        & ruby bin/rails g migration addPossession_lostToGamelog possession_lost:integer
        & ruby bin/rails g migration addFoulsToGamelog fouls:integer
        & ruby bin/rails g migration addWas_fouledToGamelog was_fouled:integer
        & ruby bin/rails g migration addOffsidesToGamelog offsides:integer
        & ruby bin/rails g migration addSavesToGamelog saves:integer
        & ruby bin/rails g migration addGoals_preventedToGamelog goals_prevented:integer
        & ruby bin/rails g migration addMinutes_playedToGamelog minutes_played:integer
        

        '''
