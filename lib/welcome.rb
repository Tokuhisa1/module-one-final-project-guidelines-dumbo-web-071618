class Welcome

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
    puts pastel.white(font.write("DEAD"))
  end
end

end
