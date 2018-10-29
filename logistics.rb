# logistics.rb
module Logistics
  def user_loss
    user.loss
    dealer.win
    dealer.bank.get(game_bank)
    self.game_bank = 0
  end

  def user_win
    user.win
    user.bank.get(game_bank)
    dealer.loss
    self.game_bank = 0
  end

  def user_fifty_fifty
    user.fifty_fifty
    dealer.fifty_fifty
    user.bank.bet_return
    dealer.bank.bet_return
    self.game_bank = 0
  end

  def open_cards
    user.lookup
    dealer.lookup
    dealer.hand.open_cards
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
    user.get
    2.times { user_get_card }
    dealer.get
    2.times { dealer_get_card }
  end

  def user_get_card
    new_card = deck.give_out
    new_card.open!
    user.hand.get_card new_card
    user.hand.calc_sum
  end

  def dealer_get_card
    dealer.hand.get_card deck.give_out
    dealer.hand.calc_sum
  end

  def next_card
    user_get_card
    dealer_next_step if dealer.hand.cards.size < 3
  end

  def dealer_next_step
    dealer.hand.sum >= 17 ? dealer.pass : dealer.get
    dealer_get_card if dealer.step == :get
  end

  def compare_sums
    case user.hand.sum <=> dealer.hand.sum
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

  # def game_over?
  #   user_balance = user.bank.balance
  #   dealer_balance = dealer.bank.balance
  #   raise 'GAME OVER!' if user_balance < Bank::BET || dealer_balance < Bank::BET

  #   false
  # rescue StandardError => err
  #   interface.message_ballance(user.name, user_balance, err) if user_balance < Bank::BET
  #   interface.message_ballance(dealer.name, dealer_balance, err) if dealer_balance < Bank::BET
  #   true
  # end

  def game_over?
    if user.bank.balance < Bank::BET || dealer.bank.balance < Bank::BET
      interface.msg_game_over(user, dealer)
      true
    else
      false
    end
  end
end
