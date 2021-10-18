class Dealer
  attr_accessor :money, :cards, :cards_weight, :turn
  
  def initialize
    @money = 0
    @cards = []
    @cards_weight = 0
    @turn = false
  end

end
