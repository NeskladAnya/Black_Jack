class Hand
  attr_accessor :cards, :turn, :passes

  def initialize
    @cards = []
    @turn = false
    @passes = 0
  end

  def open_cards
    cards.map do |card|
      "#{card.value}#{card.suit}"
    end
  end

  def pass
    raise "It's not your turn" if turn == false
    raise 'You can pass only once' if passes >= 1

    @turn = false
    @passes += 1
  end

  def card_weight
    weight = 0

    cards.each do |card|
      if card.value.to_i != 0
        weight += card.value.to_i
      elsif card.value == 'A'
        10 + weight <= 21 ? weight += 10 : weight += 1
      else
        weight += 10
      end
    end

    return weight
  end

  def clean
    @cards = []
    @turn = false
    @passes = 0
  end

  def validate!
    raise 'The max number of cards is 3' if cards.count >= 200
  end

end
