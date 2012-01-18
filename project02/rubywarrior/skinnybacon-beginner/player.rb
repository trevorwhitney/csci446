class Player
  def initialize
    @health = 20
    @captive_rescued = false
  end

  def play_turn(warrior)
    if warrior.feel.captive?
      warrior.rescue!
    elsif warrior.feel(:backward).captive?
      warrior.rescue! :backward
      @captive_rescued = true
    elsif !@captive_rescued
      warrior.walk! :backward
    elsif warrior.feel.enemy?
      if warrior.feel.to_s == "Archer"
        warrior.attack!
      elsif warrior.health > 17
        warrior.attack!
      else 
        warrior.walk! :backward
      end
    else
      if warrior.health > 17
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
