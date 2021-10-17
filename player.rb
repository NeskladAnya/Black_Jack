class Player

  
  attr_reader :name
  attr_accessor :money, :cards, :cards_weight, :move

  def initialize(name)
    @name = name
    @money = 0
    @cards = []
    @cards_weight = 0
    @move = false
  end

  def skip_move
    raise "It's not your move" if move == false

    move = false
  rescue StandardError => e
    puts e.message
  end
end
