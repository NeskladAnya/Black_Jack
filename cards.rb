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

  def handle_card(number, *participants)
    participants.each do |participant|
      cards = select_card(number)

      cards.each do |card|
        participant.cards << card 
        @deck.delete(card)
      end

      participant.cards_weight += card_weight(cards, participant)
    end
  end

  def open_cards(*participants)
    participants.each do |participant|
      if participant.role == 'player'
        puts "The player #{participant.name} cards: #{participant.cards}. Total weight is #{participant.cards_weight}."
      elsif participant.role == 'dealer'
        puts "The dealer cards: #{participant.cards}. Total weight is #{participant.cards_weight}."
      end
    end
  end

# protected

  def card_weight(cards, participant)
    weight = 0

    cards.each do |card|
      if card[0].to_i != 0
        weight += card[0].to_i
      elsif card[0] == 'A' 
        weight += 10 if 10 + participant.cards_weight <= 21
        weight += 1 if 10 + participant.cards_weight > 21
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
