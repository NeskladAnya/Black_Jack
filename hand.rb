class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def open_cards
    cards.map do |card|
      "#{card.value}#{card.suit}"
    end
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
end
