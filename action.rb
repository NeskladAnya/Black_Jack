class Action
  def assign_turn(participant)
    if Participants.all.detect.count { |participant| participant.turn == true } >= 1
      raise "It's not your turn"
    end

    participant.turn = true
  end

  def pass(participant)
    raise "It's not your turn" if participant.turn == false
    raise 'You can pass only once' if participant.passes >= 1

    participant.turn = false
    participant.passes += 1

    change_next_participant_turn(participant)
  end

  def find_winner(first, second)
    if first.cards_weight.eql?(second.cards_weight)
      winners ||= []
      winners << first
      winners << second
      return winners
    elsif first.cards_weight >= 21 && first.cards_weight < second.cards_weight
      return first
    elsif first.cards_weight <= 21 && second.cards_weight <= 21 && first.cards_weight > second.cards_weight 
      return first
    else
      return second
    end
  end

  def increase_game_played(*participants)
    participants.each { |participant| participant.game_played += 1}
  end

  def clean(*participants)
    participants.each do |participant|
      participant.cards = []
      participant.cards_weight = 0
      participant.turn = false
      participant.passes = 0
    end
  end

# protected

  def change_next_participant_turn(participant)
    next_participant = find_next_participant(participant)
    next_participant.turn = true
  end

  def find_next_participant(participant)
    current_index = Participants.all.index(participant)
    next_participant = Participants.all[current_index + 1]

    next_participant = Participants.all[0] if next_participant == nil

    return next_participant
  end
end
