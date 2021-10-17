class Bank
  attr_accessor :bank

  def initialize(amount)
    @bank = amount
  end

  def give_money(amount, *players)
    players.each do |player|
      player.money += amount
      @bank -= amount
    end

    return bank
  end

  def accept_money(amount, *players)
    players.each do |player|
      player.money -= amount
      @bank += amount
    end

    return bank
  end
end
