# deck.rb - колода карт
class Deck
  attr_reader :cards

  def initialize
    @cards = []
    create_deck_cards
    3.times { @cards.shuffle! }
  end

  def create_deck_cards
    Card::SUITES.each do |suit|
      Card::NOMINALS.each_with_index { |nominal, index| @cards << Card.new(nominal, suit, Card::VALUES[index].first) }
    end
  end

  def give_out
    cards.shift
  end
end
