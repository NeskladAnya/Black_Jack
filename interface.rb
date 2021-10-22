class Interface
  attr_accessor :main_menu_answer, :move_answer, :action

  def interface
    initialize_participants

    loop do
      main_menu if action.player.game_played >= 1
      exit(0) if main_menu_answer == 0

      new_game
      loop do
        game_end if action.game_ended?
        break if action.game_ended?

        while action.dealer.hand.turn == true
          break if action.game_ended?
          dealer_game
        end

        while action.player.hand.turn == true
          break if action.game_ended?
          player_game
        end
      rescue StandardError => e
        puts e.message
        retry
      end
    end
  rescue StandardError => e
    puts e.message
    puts 'The game is over'
  end

  def initialize_participants
    print 'Enter your name: '
    name = gets.chomp

    @action = Action.new(name, 200)
  end

  def new_game
    action.new_round
    puts "A new game begins!"

    action.make_bet
    puts "Your bet $10 is accepted"
    puts "You have $#{action.player.account.balance} on your account"

    action.new_deck
    puts "Your cards are: #{action.player.hand.open_cards}"
    puts "Your cards weight is #{action.player.hand.card_weight}"
  end

  def dealer_game
    case action.dealer_game
    when "dealer_passed"
      puts "The dealer has passed"
    when "dealer_took_card"
      puts "One card has been handled to the dealer"
    end
  end

  def player_game
    select_move

    case action.player_game(move_answer)
    when "player_passed"
      puts "You've passed"
    when "player_took_card"
      puts "Your cards are: #{action.player.hand.open_cards}"
      puts "Your cards weight is #{action.player.hand.card_weight}"
    end
  end

  def game_end
    action.game_end
    winner = action.find_winner

    puts '----------------'
    puts 'The game is over'

    puts "Your cards are: #{action.player.hand.open_cards}"
    puts "Your cards weight is #{action.player.hand.card_weight}"

    puts "The dealer cards are: #{action.dealer.hand.open_cards}"
    puts "The dealer cards weight is #{action.dealer.hand.card_weight}"

    if winner.is_a?(Array)
      puts "It's draw"
    else
      puts "The winner is #{winner.role} #{winner.name if winner.name != nil}"
    end

    puts "Your bank is $#{action.player.account.balance}"
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
