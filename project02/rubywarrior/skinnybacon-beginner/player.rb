class Player
  def initialize
    @health = 20
  end

  def play_turn(warrior)
    if warrior.feel.captive?
      warrior.rescue!
    elsif warrior.feel.enemy?
      if warrior.feel.to_s == "Archer"
        warrior.attack!
      elsif warrior.health > 7
        warrior.attack!
      else 
        warrior.walk! :backward
      end
    else
      if warrior.health > 15
        warrior.walk!
      elsif @health > warrior.health
        warrior.walk!
      else
        warrior.rest!
      end
    end
    @health = warrior.health
  end
end
