class Account
  attr_accessor :balance

  def initialize
    @balance = 0
  end

  def validate!
    raise "Your balance is 0" if balance.zero?
  end
end
