class Participants
  attr_reader :name, :role
  attr_accessor :money, :cards, :cards_weight, :turn, :passes, :game_played

  def self.all
   return @@participants
  end

  def initialize(name = nil, role)
    @@participants ||= []

    @name = name
    @role = role
    @money = 0
    @cards = []
    @cards_weight = 0
    @turn = false
    @passes = 0
    @game_played = 0

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
