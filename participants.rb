class Participants
  attr_accessor :name, :role, :hand, :account, :game_played

  def self.all
   @@participants
  end

  def initialize(role, name = nil)
    @@participants ||= []

    @name = name
    @role = role
    @hand = Hand.new
    @account = Account.new
    @game_played = 0

    @@participants << self

    validate!
  end

  def validate!
    raise 'Incorrect role' unless role == 'player' || role == 'dealer'
    raise 'A player should have a name' if role == 'player' && name.nil?

    if role == 'dealer' && @@participants.detect.count { |participant| participant.role == 'dealer' } > 1
      raise 'Only one dealer can be created'
    end
  end
end
