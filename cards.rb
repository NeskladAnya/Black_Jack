class Cards
  attr_reader :deck, :handled_cards

  CARD_SUITS = %w(♠ ♥ ♣ ♦)
  CARD_VALUES = %w(2 3 4 5 6 7 8 9 10 B D K A)

  def initialize
    @deck = []

    CARD_VALUES.each do |value|
      CARD_SUITS.each do |suit|
        deck << value + suit
      end
    end
  end

  def handle_card(number, *players)
    players.each do |player|
      cards = select_card(number)
      player.cards_weight += card_weight(cards)
      
      cards.each do |card|
        player.cards << card 
        @deck.delete(card)
      end
    end
  end

# protected

  def card_weight(cards)
    weight = 0

    cards.each do |card|
      if card[0].to_i != 0
        weight += card[0].to_i
      else
        weight += 10
      end
    end

    return weight
  end

  def select_card(number)
    @handled_cards ||= []

    cards = deck.sample(number)
    cards.each { |card| handled_cards << card}

    return cards
  end
end
