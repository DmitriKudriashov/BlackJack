# balack_jack.rb
class BlackJack
  attr_reader :user, :dealer, :number, :interface

  def initialize
    @dealer = Gamer.new('Computer')
  end

  def start
    @interface = Interface.new
    dealer.new_game_init
    name_new = interface.ask_user_name
    @user = Gamer.new(name_new)
    user.new_game_init
    @number = 0
    loop do
      @number += 1
      game = Game.new(user, dealer, number, interface)
      break if game.game_over?

      interface.start_accepted ? game.start : break
    end
  end
end
