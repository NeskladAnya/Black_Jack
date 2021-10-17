class Bank

  def give_money(amount, *players)
    players.each { |player| player.money += amount }
  end

  def accept_money(amount, *players)
    players.each { |player| player.money -= amount }
  end
end
