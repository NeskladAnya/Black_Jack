class Participants
  attr_reader :name, :role
  attr_accessor :money, :hand, :passes, :game_played, :turn

  def self.all
   return @@participants
  end

  def initialize(name = nil, role)
    @@participants ||= []

    @name = name
    @role = role
    @hand = Hand.new
    @money = 0
    @passes = 0
    @game_played = 0
    @turn = false

    validate!

    @@participants << self  
  end

  def validate!
    raise 'Incorrect role' unless role == 'player' || role == 'dealer'
    raise 'A player should have a name' if role == 'player' && name == nil

    if role == 'dealer' && @@participants.detect.count { |participant| participant.role == 'dealer' } != 0
      raise 'Only one dealer can be created'
    end
  end
end
