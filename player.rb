class Player
  attr_reader :name
  attr_accessor :money, :cards

  def initialize(name)
    @name = name
    @money = 0
    @cards = []
  end
end
