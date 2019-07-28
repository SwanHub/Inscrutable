class Move < ActiveRecord::Base
  belongs_to :games

  def choose_random_move_type
      random_move = ["shift", "reverse", "swap", "jump"].sample
      update(move_type: random_move)
      random_move
  end

  def sync_board_state(board)
      update(start_board_0: board[0])
      update(start_board_1: board[1])
      update(start_board_2: board[2])
      update(start_board_3: board[3])
      update(start_board_4: board[4])
      update(start_board_5: board[5])
      update(start_board_6: board[6])
      update(start_board_7: board[7])
      update(start_board_8: board[8])
      board
  end

  def current_board
      [start_board_0, start_board_1, start_board_2, start_board_3,
      start_board_4, start_board_5, start_board_6, start_board_7, start_board_8]
  end

  def shift(shift_amount)
      update(shift: shift_amount)
      current_board.map.with_index {|el, i| current_board[(i - (shift_amount))%9]}
  end

  def reverse
      current_board.reverse!
  end

  def swap(piece_1, piece_2)
      update(swap_1: piece_1)
      update(swap_2: piece_2)
      board = current_board
      index_1 = board.index(piece_1)
      index_2 = board.index(piece_2)
      board[index_1] = piece_2
      board[index_2] = piece_1
      board
  end

  def jump(starting_piece, number_of_pieces_moved, jump_movement)
      update(jump_first_piece: starting_piece)
      update(jump_number_of_pieces: number_of_pieces_moved)
      update(jump_places: jump_movement)
      board = current_board
      starting_index = board.index(starting_piece)
      slice_of_array = board.slice!(starting_index, number_of_pieces_moved)
      if jump_movement > 0 && (starting_index + (jump_movement))%(9-number_of_pieces_moved) == 0
        new_index = starting_index + jump_movement
      else
        new_index = (starting_index + (jump_movement))%(9-number_of_pieces_moved)
      end
      board.insert(new_index, slice_of_array).flatten!
  end

end
