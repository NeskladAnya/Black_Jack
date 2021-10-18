class Player
  attr_reader :name
  attr_accessor :money, :cards, :cards_weight, :turn

  def initialize(name)
    @name = name
    @money = 0
    @cards = []
    @cards_weight = 0
    @turn = false
  end

end
