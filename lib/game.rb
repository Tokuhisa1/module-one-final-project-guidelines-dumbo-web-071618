class Game  < ActiveRecord::Base
  has_many :characters
  has_many :levels
  #Game Mechanics



  def self.start
    font = TTY::Font.new(:doom)
    prompt = TTY::Prompt.new
    pastel = Pastel.new

    puts pastel.black.on_magenta(font.write("  West  ",letter_spacing: 3))
    puts pastel.black.on_red(font.write("Kingdom"))

    menu = ["New Game","Continue"]
    value = prompt.select("Choose your destiny...", %w(New_Game Continue))

    if value == "Continue"
      system "clear"
      continue_game
    else
      new_game
    end
  end

  def self.new_game
    font = TTY::Font.new(:doom)
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    system "clear"
    puts pastel.white.on_red(("What's Your Name?"))
    name = gets.chomp
    new_user = Character.create(name: name)
    puts pastel.white.on_red(font.write("Welcome: #{name}"))
  end

  def self.continue_game
    font = TTY::Font.new(:doom)
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    menu = choose_game
    value = prompt.select("Choose your destiny...", menu)
  end

  def self.choose_game

    Character.all.collect do |character|
      " #{character.name}, level: #{Random.new.rand(1..3)}"
    end
  end


end
