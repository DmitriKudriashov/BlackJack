# interface.rb
require 'io/console'

class Interface
  def ask_user_name
    system('clear')
    puts 'INPUT YOU NAME:'
    gets_with_esc.chomp.strip.capitalize
  end

  def game_number(number, stake)
    system('clear')
    devider_double
    puts "GAME No: #{number}  STAKE: #{stake} "
    devider_double
  end

  def gamer_info(opt = {})
    puts "  #{opt[:gamer]}: #{opt[:name]} step: #{opt[:step]} \n cards: #{opt[:cards]} sum: #{opt[:sum]}, balance: #{opt[:balance]} "
  end

  def control_sum(sum)
    puts " ( control sum: #{sum} )" # for code debug only !
  end

  def devider_double
    puts '=' * 50
  end

  def devider_simple
    puts '-' * 50
  end

  def user_view_result(status_text)
    puts "\n #{'-' * 50} \n #{' ' * 15}  #{status_text} \n #{'-' * 50} "
  end

  def menu_head
    devider_simple
    puts '       Select Action '
    devider_simple
  end

  def select_from(menu)
    menu.each_with_index { |text, item| puts "#{item + 1}. #{text}" }
  end

  def start_accepted
    loop do
      puts "\n #{'=' * 50}
        Start new game?
     (Y)es  /  (ESC) for Exit "
      char = STDIN.getch
      return false if char.ord == 27
      return true if char.chomp.casecmp('Y').zero?
    end
  end

  def message_ballance(name, balance, err)
    puts "\nFor #{name} Balance: #{balance}! \n #{err.message}"
  end

  def msg_game_over
    'GAME OVER !'
  end

  def gets_with_esc
    name = ''
    loop do
      char = STDIN.getch
      return '' if char.ord == 27
      return name if char.ord == 13

      print char
      name += char
    end
  end
end
