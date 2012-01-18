class Player
  def initialize
    @health = 20
    @turned = false
  end

  def play_turn(warrior)
    if !@turned
      warrior.pivot!
      @turned = true
    elsif warrior.feel.enemy?
      if warrior.feel.to_s == "Archer"
        warrior.attack!
      elsif warrior.health > 15
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
