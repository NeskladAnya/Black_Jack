class Interface
  attr_reader :player, :dealer, :bank, :action
  attr_accessor :main_menu_answer, :move_answer, :cards, :game_ended

  def game_ended
    @game_ended = false
  end

  def interface
    initialize_participants
    initialize_bank
    initialize_action

    loop do
      main_menu if player.game_played >= 1
      exit(0) if main_menu_answer == 0

      new_game
      loop do
        game_end if @game_ended == true 
        break if @game_ended == true

        while dealer.turn == true
          break if @game_ended == true
          dealer_game
        end

        while player.turn == true
          break if @game_ended == true
          player_game
        end
      end
    end
    
  end

#  protected

  def initialize_participants
    print 'Enter your name: '
    name = gets.chomp

    @player = Participants.new(name, "player")
    @dealer = Participants.new("dealer")
  end

  def initialize_bank
    @bank = Bank.new(200)
    bank.give_money(100, player, dealer)
  end

  def initialize_action
    @action = Action.new
    action.assign_turn(player)
  end

  def new_game
    raise "Insufficient funds!" if dealer.money <= 0 || player.money <= 0
    puts "A new game begins!"
    action.clean(player, dealer)
    bank.accept_money(10, player, dealer)
    puts "Your bet $10 is accepted"
    puts "You have $#{player.money} on your account"

    initialize_deck
    action.assign_turn(player)
    @game_ended = false
  end

  def initialize_deck
    @cards = Cards.new
    cards.handle_card(2, player, dealer)

    puts "Your cards are: #{player.cards}"
    puts "Your cards weight is #{player.cards_weight}"
  end

  def player_game
    select_move
    case @move_answer
    when 1
      action.pass(player)
      puts "You've passed"
    when 2
      raise 'You already have three cards' if player.cards.count >= 3
      cards.handle_card(1, player)
      puts "Your cards are: #{player.cards}"
      puts "Your cards weight is #{player.cards_weight}"
      player.turn = false
      action.change_next_participant_turn(player)
    when 3
      player.turn = false
      @game_ended = true
    end
  end

  def dealer_game
    if dealer.cards_weight >= 17 && dealer.passes == 0
      action.pass(dealer)
      puts "The dealer has passed"
    elsif dealer.cards_weight < 17 && dealer.cards.count < 3
      cards.handle_card(1, dealer)
      puts "One card was handled to the dealer"
      dealer.turn = false
      action.change_next_participant_turn(dealer)
    else
      dealer.turn = false
      @game_ended = true
    end
  end

  def game_end
    puts 'The game is over'
    cards.open_cards(player, dealer)
    action.increase_game_played(player, dealer)

    winner = action.find_winner(player, dealer)
    if winner.is_a?(Array)
      puts "It's draw"
      bank.give_money(bank.bank/2, player, dealer)
    else
      puts "The winner is #{winner.role} #{winner.name if winner.name != nil}"
      bank.give_money(bank.bank, winner)
    end
    puts "Your bank is #{player.money}"
    @game_ended = true
  end

  def main_menu
    puts 'If you want to start a new game, type 1'
    puts 'To exit, type 0'

    @main_menu_answer = gets.chomp.to_i
  end

  def select_move
    puts 'Select your next action'
    puts '---------------------'
    puts 'To skip your turn, type 1'
    puts 'To add a card, type 2'
    puts 'To open cards, type 3'

    @move_answer = gets.chomp.to_i
  end
end
