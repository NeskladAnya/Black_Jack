class Action
  attr_accessor :game_status, :player, :dealer, :bank, :game_result, :cards

  def initialize(name, amount)
    @game_status = "started"
    @player = Participants.new("player", name)
    @dealer = Participants.new("dealer")
    @bank = Bank.new(amount)
    @game_result = nil

    bank.give_money(amount/2, player, dealer)
  end

  def new_round
    player.account.validate!
    dealer.account.validate!

    player.hand.clean
    dealer.hand.clean

    player.hand.turn = true
    @game_status = "started"
  end

  def make_bet
    bank.accept_money(10, player, dealer)
  end

  def new_deck
    @cards = Deck.new
    cards.handle_card(2, player, dealer)
  end

  def game_end
    increase_game_played
    winner = find_winner
    
    if winner.is_a?(Array)
      bank.give_money(bank.bank/2, player, dealer)
    else
      bank.give_money(bank.bank, winner)
    end

    @game_status == "ended"
  end

  def game_ended?
    if (player.hand.cards.count == 3 && dealer.hand.cards.count == 3) || (player.hand.cards.count == 3 && dealer.hand.cards.count == 2 && dealer.hand.passes == 1) || game_status == "ended"
      true
    else
      false
    end
  end

  def dealer_game
    if dealer.hand.card_weight >= 17 && dealer.hand.passes == 0
      dealer.hand.pass
      player.hand.turn = true

      return "dealer_passed"
    elsif dealer.hand.card_weight < 17 && dealer.hand.cards.count < 3
      cards.handle_card(1, dealer)

      dealer.hand.turn = false
      player.hand.turn = true

      return "dealer_took_card"
    else
      dealer.hand.turn = false
      @game_status = "ended"
      
      return "dealer_end"
    end
  end

  def player_game(answer)
    case answer
    when 1
      player.hand.pass
      dealer.hand.turn = true

      return "player_passed"
    when 2
      player.hand.validate!

      cards.handle_card(1, player)

      player.hand.turn = false
      dealer.hand.turn = true

      return "player_took_card"
    when 3
      player.hand.turn = false
      @game_status = "ended"
    end
  end

  def find_winner
    if player.hand.card_weight.eql?(dealer.hand.card_weight)
      winners ||= []
      winners << player
      winners << dealer
      return winners
    elsif player.hand.card_weight >= 21 && player.hand.card_weight < dealer.hand.card_weight
      return player
    elsif player.hand.card_weight <= 21 && dealer.hand.card_weight <= 21 && player.hand.card_weight > dealer.hand.card_weight 
      return player
    elsif player.hand.card_weight <= 21 && dealer.hand.card_weight > 21
      return player
    else
      return dealer
    end
  end

  def increase_game_played
    player.game_played += 1
    dealer.game_played += 1
  end
end
