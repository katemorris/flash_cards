require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'

class Game
  attr_reader :deck, :round

  def initialize
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    card_4 = Card.new("What is the capital of Washington?", "Seattle", :Geography)
    cards = [card_1, card_2, card_3, card_4]
    @deck = Deck.new(cards)
  end

  def start
    puts "Welcome! You're playing with #{@deck.count} cards."
    @round = Round.new(@deck)
    turn
  end

  def turn
    until @round.turns.count == @deck.count
      puts "This is card number #{@round.turns.count + 1} out of #{@deck.count}."
      puts "Question: #{@round.current_card.question}"
      string = gets.chomp
      @round.take_turn(string)
      puts @round.turns.last.feedback
    end
    end_game
  end

  def end_game
    if @round.turns.count == @deck.count
      puts "****** Game over! ******"
      puts "You had #{@round.number_correct} correct guesses out of #{@deck.count} for a total score of #{@round.percent_correct.round}%."
      puts "Geography - #{@round.percent_correct_by_category(:Geography).round}% correct"
      puts "STEM - #{@round.percent_correct_by_category(:STEM).round}% correct"
      exit
    else
      puts "What Happened?"
    end
  end

end
