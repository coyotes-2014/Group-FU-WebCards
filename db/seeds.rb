
Deck.create(name: "Ruby Terms")
Deck.create(name: "World Capitals")

def load_terms_cards
    first_read = []
    File.open("db/ruby_terms.txt", "r") do |file|
      file.each_line do |line|
        first_read << line.chomp unless line == "\n"
      end
    end
    first_read.each_slice(2) do |slice|
      Card.create({:definition=> slice[0], :term => slice[1], :answered=> false, :deck_id=> 1})
    end
end

def load_capital_cards
    first_read = []
    File.open("db/world_capitals.txt", "r") do |file|
      file.each_line do |line|
        first_read << line.chomp unless line == "\n"
      end
    end
    first_read.each_slice(2) do |slice|
      Card.create({:definition=> slice[0], :term => slice[1], :answered=> false, :deck_id=> 2})
    end
end

load_terms_cards
load_capital_cards