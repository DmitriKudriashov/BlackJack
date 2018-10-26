# logistics.rb
module Logistics
  def user_loss
    user.loss
    dealer.win
    dealer.change_bank(game_bank)
    self.game_bank = 0
  end

  def user_win
    user.win
    user.change_bank(game_bank)
    dealer.loss
    self.game_bank = 0
  end

  def user_fifty_fifty
    user.fifty_fifty
    dealer.fifty_fifty
    user.bet_return
    dealer.bet_return
    self.game_bank = 0
  end

  def open_cards
    user.lookup
    dealer.lookup
    check_sums
  end

  def action_card_next
    next_card
    open_cards
  end

  def user_pass
    user.pass
    dealer_next_step
  end

  def give_cards
    2.times { user_get_card }
    2.times { dealer_get_card }
  end

  def user_get_card
    new_card = deck.give_out # deck.give_a  #  for debug sum Aces only
    new_card.open!
    user.get_card new_card
    user.calc_sum
  end

  def dealer_get_card
    dealer.get_card deck.give_out
    dealer.calc_sum
  end

  def next_card
    user_get_card
    dealer_next_step if dealer.cards.size < 3
    # false
  end

  def dealer_next_step
    dealer.sum >= 17 ? dealer.pass : dealer.get
    dealer_get_card if dealer.step == :get
  end

  def compare_sums
    case user.sum <=> dealer.sum
    when -1
      user_loss
    when 0
      user_fifty_fifty
    when 1
      user_win
    end
  end

  def check_sums
    user_level = user.hand.level
    dealer_level = dealer.hand.level
    user_loss if user_level == :over21
    user_loss if user_level == :under21 && dealer_level == :equel21
    compare_sums if user_level == :under21 && dealer_level == :under21
    user_fifty_fifty if user_level == :equel21 && dealer_level == :equel21
    user_win if user_level != :over21 && dealer_level == :over21
    user_win if user_level == :equel21 && dealer_level != :equel21
  end

  def game_over?
    raise interface.msg_game_over if user.balance < Bank::BET || dealer.balance < Bank::BET

    false
  rescue StandardError => err
    interface.message_ballance(user.name, user.balance, err) if user.balance < Bank::BET
    interface.message_ballance(dealer.name, dealer.balance, err) if dealer.balance < Bank::BET
    true
  end
end
