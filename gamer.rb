# gamer.rb
class Gamer
  include Validation

  validate :name, :presence
  validate :name, :format, /^[A-Z]{3,}$/i

  attr_reader :name, :cards, :bank, :step, :status, :status_text, :hand

  def initialize(name)
    @name = name
    @bank = Bank.new
    validate!
  end

  def new_game_init
    self.hand = Hand.new
    self.step = :none
    self.status = :none
    self.status_text = 'NONE GAME!'
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

  def make_step(value)
    self.step = value
  end

  private

  attr_writer :cards, :step, :status, :status_text, :hand
end
