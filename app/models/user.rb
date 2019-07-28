class User < ActiveRecord::Base
  has_many :matches

  def self.hello
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts "                                    Welcome to the Game:"
      puts ""
      puts Paint['       123456 78   91 234567 891234 56789   12  34 567891  2345  67891  23     456789', :red, :bright, :faint]
      puts Paint['         12   345  67 89     12     34  56  78  91   23   45  67 89  12 34     56    ', :red, :bright, :faint]
      puts Paint%['         78   91 2 34   56   78    %{black_text}  234567 89123  45     6789  ', :red, :bright, black_text: ["I N S C R U T A B L E", :black]]
      puts Paint['         12   34  567     89 12     34  56  78  91   23   45  67 89  12 34     56    ', :red, :bright, :faint]
      puts Paint['       789123 45   67 891234 567891 23   45 678912   34   56  78 91234  567891 234567', :red, :bright, :faint]
      puts ""
      puts ""
      puts "                          Your OBJECTIVE is to unscramble the numbers"
      puts "                           and return them to their correct sequence"
      puts "                                       In Four Moves."
      puts ""
      puts "                                 Sign in or create new user "
      puts "                                  by typing username below: "
      puts ""
      puts ""
  end

  # creates new match associated with this user.
  def new_match
      new_match = Match.create
      matches << new_match
      new_match
  end

  # after you've found / created username, say hello.
  def hello_again
      if self.true_if_new_player
          puts ""
          puts ""
          puts ""
          puts "                               Welcome to Inscrutable #{name}!"
          puts ""
      else
          puts ""
          puts ""
          puts ""
          puts "                               Great to see you again #{name}!"
          puts ""
          puts ""
      end
  end

  def options_menu
      menu = true
      until menu == false
            prompt = TTY::Prompt.new
            puts ""
            puts ""
            user_response = prompt.select("options:", %w(play stats leaderboard motto leave), active_color: :cyan)
            system("clear")
            if user_response == "play"
                menu = false
            elsif user_response == "stats"
                  personal_stats
            elsif user_response == "leaderboard"
                  if Match.all.count == 0
                    puts ""
                    puts "                               no games played yet. get cracking."
                    puts Paint['                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
                  else
                     self.class.general_leaderboard
                  end
            elsif user_response == "motto"
                  puts ""
                  puts "                                      S E T   M O T T O"
                  puts ""
                  puts ""
                  puts ""
                  puts ""
                  puts ""
                  puts ""
                  puts ""
                  puts ""
                  puts ""
                  puts ""
                  puts ""
                  puts ""
                  motto_input = prompt.ask("            input new motto:", active_color: :red)
                  puts Paint['            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
                  puts Paint['            (see updated motto in stats page)', :red, :faint]
                  update(motto: motto_input)
            elsif user_response == "leave"
                  menu = false
                  User.bye
                  exit
            end
      end
  end


  #### GENERAL LEADERBOARD STATS --------------------------------------------
  def self.general_leaderboard
      puts ""
      puts "                                      GENERAL LEADERBOARD "
      puts ""
      puts "                   Fastest Victory: #{fastest_victory}"
      puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
      puts "                   Most games played: #{most_games_played[:total_games]} – #{most_games_played[:user]}"
      puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
      puts "                   Best Win Percentage: #{best_win_percentage[:win_percentage]}% – #{best_win_percentage[:user]}"
      puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
      puts "                   Most Wins: #{most_wins[:total_wins]} – #{most_wins[:user]}"
      puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
      puts "                   Most Losses: #{most_losses[:total_losses]} – #{most_losses[:user]}"
      puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
      puts "                   Total Wins: #{total_win_count}"
      puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
      puts "                   Total Losses: #{total_lose_count}"
  end

  def self.all_finished_games
      all.map{|user| user.all_finished_games}.flatten
  end

  def self.all_wins
      all_finished_games.select{|game| game.result == "win"}
  end

  def self.all_losses
      all_finished_games.select{|game| game.result == "lose"}
  end

  def self.total_games_played
      all_finished_games.count
  end

  def self.total_win_count
      all_wins.count
  end

  def self.total_lose_count
      all_losses.count
  end

  def self.fastest_victory
      winners = all_wins.map{|game| {match_id: game.match_id, total_time: game.total_time}}
      fastest_victory = winners.min_by {|user| user[:total_time]}
      match_id = Match.find(fastest_victory[:match_id])
      username = (User.find(match_id.user_id)).name
      "#{fastest_victory[:total_time].round(2)} seconds - #{username}"
  end

  def self.best_win_percentage
      user_totals = all.map{|user| {user: user.name, win_percentage: user.win_percentage}}
      only_users_who_have_completed_games = user_totals.select{|user| user[:win_percentage]>0}
      only_users_who_have_completed_games.max_by{|user| user[:win_percentage]}
  end

  def self.most_games_played
      user_totals = all.map{|user| {user: user.name, total_games: user.game_count}}
      user_totals.max_by{|user| user[:total_games]}
  end

  def self.most_losses
      user_totals = all.map{|user| {user: user.name, total_losses: user.total_losses}}
      user_totals.max_by{|user| user[:total_losses]}
  end

  def self.most_wins
      user_totals = all.map{|user| {user: user.name, total_wins: user.total_wins}}
      user_totals.max_by{|user| user[:total_wins]}
  end


  #### PERSONAL USER STATS --------------------------------------------
  def personal_stats
      if self.true_if_new_player
          puts ""
          puts "                          you don't have any stats yet. Get cracking."
          puts Paint['                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
      else
          puts ""
          puts "                                      PERSONAL STATS"
          puts ""
          puts "                   Username '#{name}' created: #{created_at.strftime("%B %d, %Y")}"
          puts "                   Motto: #{motto}"
          puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
          puts "                   Last Game Played On: #{most_recent_game_date.strftime("%B %d, %Y")}"
          puts "                   Last Game Result: #{most_recent_game_result}"
          puts "                   Total Time: #{most_recent_game_time} seconds"
          puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
          puts "                   Total Games Played: #{game_count}"
          puts "                   Total Wins: #{total_wins}"
          puts "                   Total Losses: #{total_losses}"
          puts "                   Win percentage: #{win_percentage}%"
          puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
          puts "                   Fastest Victory: #{fastest_victory} seconds"
          puts ""
      end
  end

  def all_games
      matches.map{|match| match.games}.flatten
  end

  def all_finished_games
      all_games.select {|game| game.finish_time != nil}
  end

  def game_count
      all_finished_games.count
  end

  def most_recent_match
      matches.last
  end

  def most_recent_game
      all_finished_games.last
  end

  def most_recent_game_date
      most_recent_game.finish_time
  end

  def most_recent_game_time
      most_recent_game.total_time.round(2)
  end

  def most_recent_game_result
      most_recent_game.result
  end

  def true_if_new_player
      matches == []
  end

  def wins
      all_finished_games.select {|game| game.result == "win"}
  end

  def total_wins
      wins.count
  end

  def fastest_victory
      wins.map{|win| win.finish_time - win.created_at}.min.round(2)
  end

  def losses
      all_finished_games.select {|game| game.result == "lose"}
  end

  def total_losses
      losses.count
  end

  def win_percentage
      ((total_wins.to_f / game_count) * 100).round(2)
  end

  def all_game_total_times
      all_finished_games.map {|game| game.total_time}
  end

  def shortest_game
      all_game_total_times.min.round(2)
  end

  def self.bye
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts Paint['                            $$$$$$   $$    $$  $$$$$$$     $$$$', :red]
      puts Paint['                            $$   $$   $$  $$   $$          $$$$', :red]
      puts Paint['                            $$   $$    $$$$    $$          $$$$', :yellow]
      puts Paint['                            $$  $$      $$     $$          $$$$', :yellow]
      puts Paint['                            $$$$$       $$     $$$$$$      $$$$', :green]
      puts Paint['                            $$  $$      $$     $$          $$$$', :blue]
      puts Paint['                            $$   $$     $$     $$', :blue]
      puts Paint['                            $$  $$      $$     $$          $$$$', :magenta]
      puts Paint['                            $$$$$       $$     $$$$$$$     $$$$', :magenta]
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
      puts ""
  end
end
