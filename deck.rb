# deck.rb - колода карт
class Deck
  attr_reader :cards

  def initialize
    @cards = []
    create_deck_cards
    3.times { @cards.shuffle! } # перемешать карты 3 раза!
    # create_arr_a # for debug sum Aces only
  end

  def create_deck_cards
    Card::SUITES.each do |suit|
      Card::NOMINALS.each_with_index { |nominal, index| @cards << Card.new(nominal, suit, Card::VALUES[index].first) }
    end
  end

  def give_out
    cards.shift
  end

  # for debug sum Aces only
  # def create_arr_a
  #   @aces = []
  #   Card::SUITES.each do |suit|
  #     @aces << Card.new('A', suit, 1)
  #   end
  # end

  # for debug sum Aces only
  # def give_a
  #   @aces.shift
  # end
end
