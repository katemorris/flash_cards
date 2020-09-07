require './lib/turn'

class Round
  attr_reader :deck, :turns

  def initialize(deck)
    @deck = deck
    @turns = []
  end

  def current_card
    @deck.cards.first
  end

  def change_card
    @deck.cards.shift
  end

  def take_turn(guess)
    turn = Turn.new(guess, change_card)
    @turns << turn
    turn
  end

  def number_correct
    @turns.select do |turn|
      turn.correct?
    end.count
  end
end
