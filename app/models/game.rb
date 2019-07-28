class Game < ActiveRecord::Base
  has_many :moves
  belongs_to :matches

  def current_board
      [board_0, board_1, board_2, board_3,
      board_4, board_5, board_6, board_7, board_8]
  end

  def new_move
      new_move = Move.create
      moves << new_move
      new_move.sync_board_state(current_board)
      new_move
  end

  def display_board
      puts ""
      puts "                                   HERE IS THE BOARD: "
      puts ""
      puts "                ######################################################"
      puts "                Values: ### #{board_0}   #{board_1}   #{board_2}   #{board_3}   #{board_4}   #{board_5}   #{board_6}   #{board_7}   #{board_8} ########"
      puts "                ######################################################"
  end

  def ready?
      prompt = TTY::Prompt.new
      puts ""
      puts "                     When you are ready, choose 'scramble' below"
      puts "                I will then scramble the board, making it INSCRUTABLE."
      puts ""
      user_response = prompt.select("ready?", %w(scramble leave), active_color: :cyan)
      if user_response == "play"
        nil
      elsif user_response == "leave"
        puts "kay, bye."
        exit
      end
  end

  def total_moves_remaining
      prompt = TTY::Prompt.new
      puts ""
      puts "                                    ################"
      prompt.warn("                                    #{remaining_moves} MOVES REMAIN...")
      puts "                                    ################"
      puts ""
  end

  def sync_board_state(board)
      update(board_0: board[0])
      update(board_1: board[1])
      update(board_2: board[2])
      update(board_3: board[3])
      update(board_4: board[4])
      update(board_5: board[5])
      update(board_6: board[6])
      update(board_7: board[7])
      update(board_8: board[8])
      board
  end

  def display_options
      puts ""
      puts "                1. Move a group of one, two or three in either direction."
      puts "                2. Shift the board in either direction."
      puts "                3. Swap two individual pieces."
      puts "                4. Reverse the sequence."
      puts ""
  end

  def which_move_type?
      prompt = TTY::Prompt.new
      puts ""
      user_response = prompt.ask("Which transformation would you like to use?", active_color: :cyan).to_i
      puts ""
      user_response
  end

  def check_for_victor
      if self.current_board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
         update(result: "win")
         update(finish_time: Time.now)
         puts "You took: #{(finish_time - created_at).round(2)} seconds."
      else
         update(result: "lose")
         update(finish_time: Time.now)
         puts "You took: #{(finish_time - created_at).round(2)} seconds."
      end
  end

  def display_win_loss_message
      prompt = TTY::Prompt.new
      puts ""
      if result == "lose"
        puts "                                        XXXXXXX"
        prompt.error("                                       YOU LOSE!")
        puts "                                        XXXXXXX"
      elsif result == "win"
        puts "                                       XXXXXXXX"
        prompt.ok("                                       YOU WIN!")
        puts "                                       XXXXXXXX"
      end
      puts ""
  end

  def incorrect_board_positions
      wrong = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      current_board.each_with_index { |el, i|
      if el != i + 1
        wrong[i] = "X"
      end
      }
      puts "                            #{wrong[0]}   #{wrong[1]}   #{wrong[2]}   #{wrong[3]}   #{wrong[4]}   #{wrong[5]}   #{wrong[6]}   #{wrong[7]}   #{wrong[8]} "
  end

  def total_time
    finish_time - created_at
  end

end
