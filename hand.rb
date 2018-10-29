# hand.rb
class Hand
  attr_reader :cards, :sum

  def initialize
    @cards = []
  end

  def calc_sum
    self.sum = 0
    cards.each { |card| self.sum += card.cost }
    self.sum += 10 if cards.map(&:cost).min == 1 && self.sum + 10 <= 21
    self.sum
  end

  def level
    case self.sum <=> 21
    when -1
      :under21
    when 0
      :equel21
    when 1
      :over21
    end
  end

  def get_card(card)
    cards << card
  end

  def cards_list
    list = ''
    cards.each { |card| list += image(card) }
    list
  end

  def image(card)
    card.open? ? "|#{card.name}| " : '| * | '
  end

  def open_cards
    cards.each(&:open!)
  end

  private

  attr_writer :cards, :sum
end
