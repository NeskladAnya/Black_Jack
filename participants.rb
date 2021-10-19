class Participants
  attr_accessor :name, :role, :money, :cards, :cards_weight, :turn

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

    validate!

    @@participants << self    
  end

  def skip_turn
    raise "It's not your turn" if turn == false

    if role == 'player'
      self.turn = false
    elsif role == 'dealer'
      self.turn = false if cards_weight >= 17
    end
  end

  def validate!
    raise 'Incorrect role' unless role == 'player' || role == 'dealer'
    raise 'A player should have a name' if role == 'player' && name == nil

    @@participants.find do |participant|
      raise 'Only one dealer can be created' if participant.role == 'dealer'
    end
  end
end
