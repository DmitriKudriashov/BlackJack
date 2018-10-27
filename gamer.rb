# gamer.rb
class Gamer
  include Validation

  validate :name, :presence
  validate :name, :format, /^[A-Z]{3,}$/i

  attr_reader :name, :cards, :bank, :sum, :step, :status, :status_text, :hand

  def initialize(name)
    @name = name
    @bank =  Bank.new
    validate!
  end

  def new_game_init
    self.cards = []
    self.hand = Hand.new
    self.step = :hide
    self.status = :none
  end

  def calc_sum
    self.hand.get cards
    self.sum = hand.calc_sum
  end

  def get_card(card)
    get
    self.cards << card
  end

  def bet_return
    bank.get(Bank::BET)
  end

  def pass
    self.step = :pass
  end

  def get
    self.step = :get
  end

  def lookup
    self.step = :lookup
  end

  def lookup?
    step == :lookup
  end

  def win
    self.status = :win
    self.status_text = 'YOU WIN ))'
  end

  def loss
    self.status = :loss
    self.status_text = 'YOU LOSS (('
  end

  def fifty_fifty
    self.status = :fifty_fifty
    self.status_text = 'VA-BANK !)'
  end

  def cards_list
    list = ''
    cards.each { |card| list += image(card) }
    list
  end

  def image(card)
    card.open? || step == :lookup ? "|#{card.name}| " : '| * | '
  end

  def make_step(value)
    self.step = value
  end

  private

  attr_writer :sum, :cards, :step, :status, :status_text, :hand
end
