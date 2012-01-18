class Player
  def play_turn(warrior)
    if warrior.feel.enemy?
      if warrior.health > 10
        warrior.attack!
      else
        warrior.walk! :backward
      end
    else
      if warrior.health > 15
        warrior.walk!
      else
        warrior.rest!
      end
    end
  end
end
