# game.rb
require 'io/console'
class Game
  include Logistics

  attr_reader :user, :dealer, :deck, :number, :game_bank, :interface

  def initialize(user, dealer, number, interface)
    @user = user
    @dealer = dealer
    @number = number
    @deck = Deck.new
    @interface = interface
  end

  def start
    run
    if user.status == :win || user.status == :fifty_fifty && user.hand.level == :equel21
      user.lookup
      dealer.lookup
    else
      action_from_menu
    end
    information
    interface.user_view_result user.status_text
  end

  private

  attr_writer :game_bank

  def run
    user.new_game_init
    dealer.new_game_init
    self.game_bank = user.bank.bet + dealer.bank.bet
    give_cards
    if user.hand.level == :equel21
      dealer_next_step
      open_cards
    end
  end

  def information
    info_user = { gamer: 'USER', name: user.name, step: user.step,
                  cards: user.cards_list, sum: user.sum, balance: user.bank.balance }
    info_dealer = { gamer: 'DEALER', name: dealer.name, step: dealer.step,
                    cards: dealer.cards_list, sum: view_sum_dealer, balance: dealer.bank.balance }
    interface.game_number(number, game_bank)
    interface.gamer_info(info_user)
    interface.devider_double
    interface.gamer_info(info_dealer)
    interface.devider_simple
    interface.control_sum(game_bank + user.bank.balance + dealer.bank.balance)
  end

  def view_sum_dealer
    dealer.lookup? ? dealer.sum.to_s : '***'
  end

  def actions_init
    @actions = { get: ['Get card', 'action_card_next'],
                 pass: %w[Pass user_pass],
                 lookup: ['Open cards', 'open_cards'] }
  end

  def menu_items
    menu_names = []
    @actions.each_value { |item| menu_names << item.first }
    menu_names
  end

  def action_from_menu
    actions_init
    loop do
      information
      interface.menu_head
      interface.select_from menu_items
      item = STDIN.getch
      break if item.ord == 27 || item.empty?

      action_by item.to_i
      break if user.lookup?

      @actions.delete(:pass) if user.step == :pass
    end
  end

  def action_by(item)
    return unless item.between?(1, @actions.keys.size)

    new_step = @actions.keys[item - 1]
    user.make_step new_step
    eval(@actions[new_step].last)
  end
end
