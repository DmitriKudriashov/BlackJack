# bank.rb
class Bank
  include Validation

  validate :balance, :negative

  BET = 10
  BANK = 100

  attr_reader :balance

  def initialize
    @balance = BANK
    validate!
  end

  def pay(money)
    @balance -= money
  end

  def get(money)
    @balance += money
  end

  def bet
    pay(BET)
    BET
  end

  def bet_return
    get(BET)
  end
end
