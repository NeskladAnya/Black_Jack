class Deck
  attr_reader :deck, :handled_cards

  CARD_SUITS = %w(♠ ♥ ♣ ♦)
  CARD_VALUES = %w(2 3 4 5 6 7 8 9 10 B D K A)

  def initialize
    @deck = []

    CARD_VALUES.each do |value|
      CARD_SUITS.each do |suit|
        deck << Card.new(value, suit)
      end
    end
  end

  def handle_card(number, *participants)
    participants.each do |participant|
      cards = select_card(number)

      cards.each do |card|
        participant.hand.cards << card 
        @deck.delete(card)
      end
    end
  end

 protected

  def select_card(number)
    @handled_cards ||= []

    cards = deck.sample(number)
    cards.each { |card| handled_cards << card}

    return cards
  end
end
