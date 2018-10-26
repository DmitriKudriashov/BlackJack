# card.rb
class Card
  attr_reader :nominal, :suit, :cost, :name, :lookup

  SUITES = ['<3', '<>', '^', '+'].freeze
  NOMINALS = %w[A 2 3 4 5 6 7 8 9 10 V D K].freeze
  VALUES = [[1, 11], [2], [3], [4], [5], [6], [7], [8], [9], [10], [10], [10], [10]].freeze

  def initialize(nominal, suit, cost)
    @nominal = nominal
    @suit = suit
    @cost = cost
    @name = nominal + suit
    @lookup = false
  end

  def open!
    self.lookup = true
  end

  def open?
    lookup
  end

  private

  attr_writer :lookup
end
