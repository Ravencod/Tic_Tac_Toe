# frozen_string_literal: true

require 'colorize'
require 'pry'
require_relative 'player'
require_relative 'board'
require_relative 'board_case'

class Game
  attr_accessor :player1, :player2, :board, :win_combo, :new_case, :selected_case

  def initialize
    puts "What's the name on Player #1 ?"
    print "> "
    @player1 = Player.new(gets.chomp, 'X')
    puts "What's the name on Player #2 ?"
    print "> "
    @player2 = Player.new(gets.chomp, 'O')
    launch_game
    initialize_win_combo
    puts "\n#{@player1.name} you play with '#{@player1.mark}' and #{@player2.name} you play with '#{@player2.mark}'"
    party
  end

  # fill the hash with all the possible winning combinasion
  def initialize_win_combo
    @win_combo = {}
    @win_combo[:combo_l1] = [@board.case_a1.case, @board.case_b1.case, @board.case_c1.case]
    @win_combo[:combo_l2] = [@board.case_a2.case, @board.case_b2.case, @board.case_c2.case]
    @win_combo[:combo_l3] = [@board.case_a3.case, @board.case_b3.case, @board.case_c3.case]
    @win_combo[:combo_c1] = [@board.case_a1.case, @board.case_a2.case, @board.case_a3.case]
    @win_combo[:combo_c2] = [@board.case_b1.case, @board.case_b2.case, @board.case_b3.case]
    @win_combo[:combo_c3] = [@board.case_c1.case, @board.case_c2.case, @board.case_c3.case]
    @win_combo[:combo_d1] = [@board.case_a1.case, @board.case_b2.case, @board.case_c3.case]
    @win_combo[:combo_d2] = [@board.case_a3.case, @board.case_b2.case, @board.case_c1.case]
  end

  # ignition game
  def launch_game
    puts "Welcome to the TIC TAC TOE board game #{@player1.name} and #{@player2.name}!\nREADY\n(tic)"
    1.times { sleep(1); print "." }
    print "\nSET\n(tac)"
    1.times { sleep(1); print "." }
    puts "\n(TOE) ! LET'S PLAY !! "
    sleep(1)
    @board = Board.new
    @board.draw_board
  end

  # ** PARTYYYYYYYYYYYYYYYYYY **
  # This method simply loop for each turn and check if there's any winner for each turn
  def party
    last_player = @player2
    begin
      last_player == @player2 ? last_player = @player1 : last_player = @player2
      next_turn(last_player.name, last_player.mark)
      @board.draw_board
      wehaveawinner = win?(last_player.mark)
      partyover = party_over?
    end while wehaveawinner.empty? && !partyover

    if !wehaveawinner.empty?
        last_player.update_status("VICTORY")
        puts ("\n \(ᵔᵕᵔ)/".cyan.bold + " W".blue + "E".magenta + " H".cyan + "A".yellow + "V".red + "E".blue + " A".magenta + " W".cyan + "I".yellow + "N".blue + "N".magenta + "E".cyan + "R".yellow + " !!!!".yellow + " \(ᵔᵕᵔ)/".magenta.bold + "\n" + "C".blue + "O".magenta + "N".cyan + "G".yellow + "R".blue + "A".magenta + "T".cyan + "U".yellow + "L".blue + "A".magenta + "T".cyan + "I".yellow + "O".blue + "N".magenta + "S ".cyan + "#{last_player.name.upcase}".green + " ( ⌐ ■ _■ ) ").bold
    elsif partyover
        puts "AAaaaaw, YOU BOTH SUCK ¯\_(ツ)_/¯ \n But practive makes perfect sooo..PRACTICE ( ͡° ͜ʖ ͡°)".red.bold
    end
end

  # ** NEXT TURN **
  # This method will prompt the next player for next action and update the case accordingly
  def next_turn(player, mark)
    # prompt player one for to select a new case to mark
    print "#{player} where do you want to place your '#{mark}' ? (ex: A1 or B3) > "
    @selected_case = gets.chomp.upcase

    # check if the case entered exists or is valid
    valid_case?(@selected_case, player)

    # map the case to the variable and stock it in local variable 'new_case'
    empty_case?(player)

    # check if the case is available (empty)

    # if everything is all good, confirm the X or O place and change the value accordingly
    @new_case.update_case_value(mark)
    puts "new #{mark} set on #{@selected_case} by #{player}"
  end

  # ** VALID CASE ? **
  # This method checks if the number of the case entered by the player is valid
  def valid_case?(value, player)
    while !@selected_case.match?(/A1|A2|A3|B1|B2|B3|C1|C2|C3/)
      print "Sorry #{player} this is not a valid case, please try again : "
      @selected_case = gets.chomp.upcase
    end
    true
  end

  def empty_case?(player)
    map_case(@selected_case)
    until @new_case.case == " "
      print "Sorry #{player} but this case is already taken, please try another one : "
      @selected_case = gets.chomp.upcase
      valid_case?(@selected_case, player)
      map_case(@selected_case)
    end
    true
  end

  # ** MAP CASE **
  # This method map the case with the corresponding instance variable of board
  def map_case(value)
    case value
    when 'A1'
      @new_case = @board.case_a1
    when 'A2'
      @new_case = @board.case_a2
    when 'A3'
      @new_case = @board.case_a3
    when 'B1'
      @new_case = @board.case_b1
    when 'B2'
      @new_case = @board.case_b2
    when 'B3'
      @new_case = @board.case_b3
    when 'C1'
      @new_case = @board.case_c1
    when 'C2'
      @new_case = @board.case_c2
    when 'C3'
      @new_case = @board.case_c3
    end
  end

  # ** WIN ? **
  # This method checks if the player (in argument) has won this turn
  def win?(mark)
    initialize_win_combo
    rslt = ""
    @win_combo.each do |k, v|
       # binding.pry
      next unless v[0] == mark && v[1] == mark && v[2] == mark
      rslt = v
      break
    end
    return rslt
  end

  def party_over?
    rslt = true
    @board.board.flatten.each { |c| rslt = false if c == " "}
    rslt
  end
end

Game.new
