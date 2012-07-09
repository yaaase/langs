class Player
  def initialize
    @prev_health ||= 0
  end

  def play_turn(warrior)
    @prev_health, @health = @health, warrior.health
    action = Factory.new(warrior, @prev_health, @health).create_action!
    action.act!
  end
end

# TODO the Factory class currently decides all application logic...
# Action and subclasses are simple wrappers around warrior class actions.
# Once concepts (like "create_aggressive_action!") emerge,
# best to delegate decision-responsiblities to the action class?
# Or better to keep conditional logic in one place and rely on polymorphism?
#
# Seems that an action probably shouldn't know anything about why it's doing
# what it's doing, but then again do I need that wrapper class?  Maybe a
# "decision" class is a better idea...

class Factory
  def initialize(warrior, prev_health, health)
    @warrior, @prev_health, @health = warrior, prev_health, health
  end

  def create_action!
    if should_rest? && safe_to_rest?
      create_passive_action!
    else
      create_aggressive_action!
    end
  end

  def create_aggressive_action!
    if @warrior.feel.captive?
      Rescue.new(@warrior)
    elsif @warrior.feel.empty?
      Walk.new(@warrior)
    else
      Attack.new(@warrior)
    end
  end

  def create_passive_action!
    Rest.new(@warrior)
  end

  def should_rest?
    @health < 20
  end

  def safe_to_rest?
    !under_attack? && @warrior.feel.empty?
  end

  def under_attack?
    @prev_health > @health
  end
end

class Action
  def initialize(warrior)
    @warrior = warrior
  end

  def act!
    raise "this method must be overwritten in subclass"
  end
end

class Walk < Action
  def act!
    @warrior.walk!
  end
end

class Attack < Action
  def act!
    @warrior.attack!
  end
end

class Rescue < Action
  def act!
    @warrior.rescue!
  end
end

class Rest < Action
  def act!
    @warrior.rest!
  end
end
