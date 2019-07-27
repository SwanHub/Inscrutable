class Match < ActiveRecord::Base
  has_many :games
  belongs_to :users

  def new_game
    new_game = Game.create
    self.games << new_game
    new_game
  end

  def display_record
    win_loss_array = self.games.map {|game| game.result}
    losses = win_loss_array.select {|result| result == "lose"}.count
    wins = win_loss_array.select {|result| result == "win"}.count
    puts ""
    puts "                           Wins: #{wins}"
    puts "                           Losses: #{losses}"
    puts ""
  end

  def play_again?
    prompt = TTY::Prompt.new
    response = prompt.yes?('Do you want to play again?', active_color: :cyan)
    if response == true
      "play on" # doesn't appear anywhere. 
    elsif response == false
      self.update(keep_playing: false)
      self.update(finish_time: Time.now)
    else
      puts "that's not a valid option. Press 'y' to continue. Or 'n' to exit."
    end
  end

end
