# frozen_string_literal: true

require 'colorize'

class Board
  attr_accessor :case_a1, :case_a2, :case_a3, :case_b1, :case_b2
  attr_accessor :case_b3, :case_c1, :case_c2, :case_c3, :board

  def initialize
    @case_a1 = BoardCase.new
    @case_a2 = BoardCase.new
    @case_a3 = BoardCase.new
    @case_b1 = BoardCase.new
    @case_b2 = BoardCase.new
    @case_b3 = BoardCase.new
    @case_c1 = BoardCase.new
    @case_c2 = BoardCase.new
    @case_c3 = BoardCase.new
    # @board = [[@case_a1.case, @case_b1.case, @case_c1.case], [@case_a2.case, @case_b2.case, @case_c2.case], [@case_a3.case, @case_b3.case, @case_c3.case]]
  end

  def draw_board
    @board = [[@case_a1.case, @case_b1.case, @case_c1.case], [@case_a2.case, @case_b2.case, @case_c2.case], [@case_a3.case, @case_b3.case, @case_c3.case]]
      print "\n" + "=".red * 33 + "\n"
      print "||    ".red + " | " + "  A   |   B   |   C  " + " ||".red + "\n"
      print "||".red + "_____" + "|_" + "______|_______|_______" + "||".red + "\n"
      print "||    ".red + " | " + "                      ||".red
      print "\n" + "||".red + "  1  |   #{@board[0][0]}   |   #{@board[0][1]}   |   #{@board[0][2]}  " + " ||".red + "\n"
      print "||".red + "_" * 5 + "| " + " ___     ___     ___" + "  ||".red + "\n"
      print "||    ".red + " | " + "                      ||".red
      print "\n" + "||".red + "  2  |   #{@board[1][0]}   |   #{@board[1][1]}   |   #{@board[1][2]}  " + " ||".red + "\n"
      print "||".red + "_" * 5 + "| " + " ___     ___     ___" + "  ||".red + "\n"
      print "||    ".red + " | " + "                      ||".red
      print "\n" + "||".red + "  3  |   #{@board[2][0]}   |   #{@board[2][1]}   |   #{@board[2][2]}  " + " ||".red + "\n"
      print "=".red * 33 + "\n"
  end
end
