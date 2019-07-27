class User < ActiveRecord::Base
  has_many :matches

    #initial hello screen.
    def self.hello
      puts ""
      puts ""
      puts "                                 Welcome to the Game:"
      puts ""
      puts Paint['    123456 78   91 234567 891234 56789   12  34 567891  2345  67891  23     456789', :red, :bright, :faint]
      puts Paint['      12   345  67 89     12     34  56  78  91   23   45  67 89  12 34     56    ', :red, :bright, :faint]
      puts Paint%['      78   91 2 34   56   78    %{black_text}  234567 89123  45     6789  ', :red, :bright, black_text: ["I N S C R U T A B L E", :black]]
      puts Paint['      12   34  567     89 12     34  56  78  91   23   45  67 89  12 34     56    ', :red, :bright, :faint]
      puts Paint['    789123 45   67 891234 567891 23   45 678912   34   56  78 91234  567891 234567', :red, :bright, :faint]
      puts ""
      puts ""
      puts "                       Your OBJECTIVE is to unscramble the numbers"
      puts "                        and return them to their correct sequence"
      puts "                                    In Four Moves."
      puts ""
      puts "                              Sign in or create new user "
      puts "                               by typing username below: "
    end

    # name is gathered by gets.chomp
    def self.user_new?(input)
      self.find_or_create_by(name: input)
    end

    # creates new match associated with this user.
    def new_match
      new_match = Match.create
      self.matches << new_match
      new_match
    end

    # after you've found / created username, say hello.
    def hello_again
      if self.true_if_new_player
        puts ""
        puts "                           Welcome to Inscrutable #{name}!"
        puts "                                 Select from below:"
        puts ""
      else
        puts ""
        puts "                            Great to see you again #{name}!"
        puts "                                 Select from below:"
        puts ""
      end
    end

    def options_menu
      menu = true
      until menu == false

        prompt = TTY::Prompt.new
        puts ""
        puts ""
        user_response = prompt.select("What would you like to see?", %w(play stats leaderboard leave ), active_color: :cyan)
        system("clear")
          if user_response == "play"
            menu = false
          elsif user_response == "stats"
            self.personal_stats
          elsif user_response == "leaderboard"
            self.class.general_leaderboard
          elsif user_response == "leave"
            menu = false
            User.bye
            exit
          end

      end
    end

    #### GENERAL LEADERBOARD STATS --------------------------------------------
    def self.general_leaderboard
        puts "                             GENERAL LEADERBOARD "
        puts ""
        puts "                   Fastest Victory: #{self.fastest_victory} seconds"
        puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
        puts "                   Most games played: #{self.most_games_played[:total_games]} – #{self.most_games_played[:user]}"
        puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
        puts "                   Best Win Percentage: #{self.best_win_percentage[:win_percentage]}% – #{self.best_win_percentage[:user]}"
        puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
        puts "                   Most Wins: #{self.most_wins[:total_wins]} – #{self.most_wins[:user]}"
        puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
        puts "                   Most Losses: #{self.most_losses[:total_losses]} – #{self.most_losses[:user]}"
        puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
        puts "                   Total Wins: #{self.total_win_count}"
        puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
        puts "                   Total Losses: #{self.total_lose_count}"

    end

    def self.all_finished_games
      self.all.map{|user| user.all_finished_games}.flatten
    end

    def self.all_wins
      self.all_finished_games.select{|game| game.result == "win"}
    end

    def self.all_losses
      self.all_finished_games.select{|game| game.result == "lose"}
    end

    def self.total_games_played
      self.all_finished_games.count
    end

    def self.total_win_count
      self.all_wins.count
    end

    def self.total_lose_count
      self.all_losses.count
    end

    def self.fastest_victory
      self.all_wins.map{|game| game.total_time}.min.round(2)
    end

    def self.all_users
      self.all
    end

    def self.best_win_percentage
      user_totals = self.all.map{|user| {user: user.name, win_percentage: user.win_percentage}} # displays all users and their total game count.
      only_users_who_have_completed_games = user_totals.select{|user| user[:win_percentage]>0}
      only_users_who_have_completed_games.max_by{|user| user[:win_percentage]}
    end

    def self.most_games_played
      user_totals = self.all.map{|user| {user: user.name, total_games: user.game_count}} # displays all users and their total game count.
      user_totals.max_by{|user| user[:total_games]}
    end

    def self.most_losses
      user_totals = self.all.map{|user| {user: user.name, total_losses: user.total_losses}} # displays all users and their total game count.
      user_totals.max_by{|user| user[:total_losses]}
    end

    def self.most_wins
      user_totals = self.all.map{|user| {user: user.name, total_wins: user.total_wins}} # displays all users and their total game count.
      user_totals.max_by{|user| user[:total_wins]}
    end


    #### PERSONAL USER STATS --------------------------------------------
    def personal_stats
      if self.true_if_new_player
        puts "                            you don't have any stats yet. Get cracking."
      else
        puts "                                      PERSONAL STATS"
        puts ""
        puts "                   Username '#{self.name}' created: #{created_at.strftime("%B %d, %Y")}"
        puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
        puts "                   Last Game Played On: #{self.most_recent_game_date.strftime("%B %d, %Y")}"
        puts "                   Last Game Result: #{self.most_recent_game_result}"
        puts "                   Total Time: #{self.most_recent_game_time} seconds"
        puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
        puts "                   Total Games Played: #{self.game_count}"
        puts "                   Total Wins: #{self.total_wins}"
        puts "                   Total Losses: #{self.total_losses}"
        puts "                   Win percentage: #{self.win_percentage}%"
        puts Paint['                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', :red, :faint]
        puts "                   Fastest Victory: #{self.fastest_victory} seconds"
      end
    end

    def all_games
      self.matches.map{|match| match.games}.flatten
    end

    def all_finished_games
      self.all_games.select {|game| game.finish_time != nil}
    end

    def game_count
      self.all_finished_games.count
    end

    def most_recent_match
      self.matches.last
    end

    def most_recent_game
      self.all_finished_games.last
    end

    def most_recent_game_date
      self.most_recent_game.finish_time
    end

    def most_recent_game_time
      self.most_recent_game.total_time.round(2)
    end

    def most_recent_game_result
      self.most_recent_game.result
    end

    def true_if_new_player
      self.matches == []
    end

    def wins
      self.all_finished_games.select {|game| game.result == "win"}
    end

    def total_wins
      self.wins.count
    end

    def fastest_victory
      self.wins.map{|win| win.finish_time - win.created_at}.min.round(2)
    end

    def losses
      self.all_finished_games.select {|game| game.result == "lose"}
    end

    def total_losses
      self.losses.count
    end

    def win_percentage
      ((self.total_wins.to_f / self.total_losses) * 100).round(2)
    end

    def all_game_total_times
      self.all_finished_games.map {|game| game.total_time}
    end

    def shortest_game
      self.all_game_total_times.min.round(2)
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
