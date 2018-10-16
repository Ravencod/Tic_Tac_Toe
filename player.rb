# frozen_string_literal: true

class Player
  attr_accessor :name, :mark, :status

  def initialize(name, mark)
    @name = name
    @mark = mark
    @status = ""
  end

  def update_status(status)
    @status = status
  end
end
