# user.rb
class User < Gamer
  validate :name, :presence
  validate :name, :format, /^[A-Z]{3,}$/i

  def initialize(name)
    super(name, 'User')
  end

  # not using . reserved!
  # def input_name
  #   puts 'YOU NAME:'
  #   name_user = gets_whith_esc.chomp.strip
  # end
end
