# hand.rb
class Hand
  attr_reader :cards, :sum, :level

  def initialize
    # @cards = []
  end

  def calc_sum
    self.sum = 0
    cards.each { |card| self.sum += card.cost }
    self.sum += 10 if cards.map(&:cost).sort.first == 1 && self.sum + 10 <= 21
    self.sum
  end

  def get(cards)
    self.cards = cards
  end

  def level
    self.level = try_on_21
  end

  def try_on_21
    case self.sum <=> 21
    when -1
      :under21
    when 0
      :equel21
    when 1
      :over21
    end
  end

  private

  attr_writer :cards, :sum, :level
end
