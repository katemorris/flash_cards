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
    @deck.cards.rotate!(1)
    @deck.cards.last
  end

  def take_turn(guess)
    turn = Turn.new(guess, change_card)
    @turns << turn
    turn
  end

  def number_correct_array
    @turns.select do |turn|
      turn.correct?
    end
  end

  def number_correct
    number_correct_array.count
  end

  def number_correct_by_category(category)
    number_correct_array.select do |correct_turn|
      correct_turn.card.category == category
    end.count
  end

  def percent_correct
    (number_correct.to_f / @turns.count) * 100
  end

  def percent_correct_by_category(category)
    total_cards = @deck.cards_in_category(category).count
    (number_correct_by_category(category).to_f / total_cards) * 100
  end
end
