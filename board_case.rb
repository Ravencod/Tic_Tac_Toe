# frozen_string_literal: true

class BoardCase
  attr_accessor :case

  def initialize
    @case = " "
  end

  def update_case_value(value)
    @case = value
  end
end
