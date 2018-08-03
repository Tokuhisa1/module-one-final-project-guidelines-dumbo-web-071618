require 'catpix'

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
    sleep(2)
    self.continue_game
  end

  def self.continue_game
    font = TTY::Font.new(:doom)
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    menu = menu_maker(choose_game)
    users = all_users
    value = prompt.select("Choose your destiny...", menu)
    load_level_1(load_player(value.to_s.split(",")[0], users))
  end

  def self.choose_game

    Character.all.collect do |character|
      [character,"#{character.name}, level: #{Random.new.rand(1..3)}"]
    end
    #returns array of [character_obj, and string value: character.name, level number]
  end

  def self.all_users
    choose_game.collect do |character|
      character[0]
    end
    #returns all users that are in the array
  end

  def self.load_player(value, user_array)
    user_array.select do |character|
      character.name == value
    end
    #takes in the string value of the prompt and finds the character it is associated with.
  end

  def self.menu_maker(arr)
    arr.collect do |name|
      name[1]
    end
    #returns array of only string values for input to show options on the continue page
  end

  def self.load_level_1(character_obj)

    font = TTY::Font.new(:doom)
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    #binding.pry
    puts "Welcome #{character_obj[0].name} on your journey!!!"
    puts "Where would you like to go? There is the dungeon to the south."
    puts "The town to the north"
    puts "Or you can play in the field"

    progress_bar
    display_map(1)

    puts
    puts

    menu = ["Dungeon time I'm a curious soul!!", "Let's see who is in the town.", "Play time is now!!! Lets frolic"]

    value = prompt.select("Where would you like to go...", menu)

    if value == menu[0]
      progress_bar
      display_caves(1)
      puts "It's too dark to see in here!"

      cave_options = ["Let's go deeper in the cave, I like the darkness", "Let's start to go back outside"]

      cave = prompt.select("Where would you like to go...", cave_options)

      if cave == cave_options[0]
        stays = true
        while stays
          cave_options
          puts "It getting chilly :/"
          value = prompt.select("Where would you like to go...", cave_options)
          if cave == cave_options[1]
            stays = false
            self.load_level_1(character_obj)
            break
          else
            cave_options
            cave = prompt.select("Where would you like to go...", cave_options)
          end
        end
      else
        self.load_level_1(character_obj)
      end

    end

    if value == menu[1]
      progress_bar
      display_town(1)

      puts "Hi welcome to town, today is the town fair let's see what's around!!!"

      town_options = ["Talk to the local vendor", "Talk to the shady character", "Let's start to go back outside"]

      town = prompt.select("Where would you like to go...", town_options)

      in_town = true
      seen = false

      while in_town
        if town == town_options[2]
          puts "#{character_obj[0].name} leaves town"
          in_town = false
          self.load_level_1(character_obj)
          break
        else
          if town == town_options[1]

              if !seen
                puts "........"
                puts "..............here take it."
                puts "#{character_obj[0].name}, recieved a samurai sword"
                character_obj[0].add_item(Item.find(2))
                town = prompt.select("Where would you like to go...", town_options)

                seen = true

              end

              puts "LEAVE ME ALONE"
              town = prompt.select("Where would you like to go...", town_options)


            elsif town == town_options[1]
              in_town = false
              self.load_level_1(character_obj)

            elsif town == town_options[0]
              puts "No food for you!!!"
              town = prompt.select("Where would you like to go...", town_options)
            end
        end
      end




    end

    if value == menu[2]
      display_boss(1)
      if character_obj[0].items.include? Item.find(2)
        puts "OoOooooooOOoOOoooo NOOOooOOO"
        puts "The samurai sword!!!!"
        sleep(5)
        puts pastel.black.on_magenta(font.write("You Win!!!",letter_spacing: 3))
      else
        puts "YOU DARE CHALLENGE ME!?!?!?"
        sleep(3)
        puts pastel.white(font.write("DEAD",letter_spacing: 3))

      end
    end

  end

  def self.load_level_2
  end

  def self.load_level_3
  end

  def self.display_caves(num)
    Catpix::print_image "lib/cave_#{num}.png",
      :limit_x => 1.8,
      :limit_y => 1.8,
      :center_x => true,
      :center_y => true,
      :bg => "black",
      :bg_fill => true,
      :resolution => "high"
  end

  def self.display_town(num)
    Catpix::print_image "lib/town_#{num}.png",
      :limit_x => 1.8,
      :limit_y => 1.8,
      :center_x => true,
      :center_y => true,
      :bg => "black",
      :bg_fill => true,
      :resolution => "high"
  end

  def self.display_boss(num)
    Catpix::print_image "lib/boss_#{num}.png",
      :limit_x => 1.4,
      :limit_y => 1.4,
      :center_x => true,
      :center_y => true,
      :bg => "black",
      :bg_fill => true,
      :resolution => "high"
  end

  def self.display_map(num)
    Catpix::print_image "lib/map_#{num}.png",
      :limit_x => 1.8,
      :limit_y => 1.8,
      :center_x => true,
      :center_y => true,
      :bg => "black",
      :bg_fill => true,
      :resolution => "high"

  end

  def self.progress_bar
    spinner = Enumerator.new do |e|
      loop do
        e.yield '|'
        e.yield '/'
        e.yield '-'
        e.yield '\\'
      end
    end

    1.upto(25) do |i|
      printf("\rLoading Map: %s", spinner.next)
      sleep(0.1)
    end

    puts
    puts

  end

end
