require 'pry'

class Player
  def play_turn(warrior)
    stairs = warrior.direction_of_stairs
    danger = false
    @direction_of_danger = Array.new
    [:left, :right, :forward, :backward].each do |direction|
      if warrior.feel(direction).enemy?
        danger = true
        @direction_of_danger << direction
      end
    end
    if danger
      if warrior.health > 10
        warrior.attack! @direction_of_danger
      else
        retreat @previous_move, warrior
      end
    else
      if warrior.health > 15
        warrior.walk! stairs
        @previous_move = stairs
      else
        warrior.rest!
      end
    end
  end

  def retreat(previous, warrior)
    case previous
      when :left
        warrior.walk! :right
      when :forward
        warrior.walk! :backward
      when :right
        warrior.walk! :left
      when :backward
        warrior.walk! :forward
    end
  end
      
end
