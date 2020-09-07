require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'

class RoundTest < Minitest::Test

  def setup
    @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    @cards = [@card_1, @card_2, @card_3]
    @deck = Deck.new(@cards)
    @round = Round.new(@deck)
  end

  def test_it_exists
    assert_instance_of Round, @round
  end

  def test_it_has_attributes
    assert_equal @deck, @round.deck
    assert_equal [], @round.turns
  end

  def test_the_return_of_the_first_card
    assert_equal @card_1, @round.current_card
  end

  def test_taking_a_turn
    new_turn = @round.take_turn("Juneau")

    assert_instance_of Turn, new_turn
    assert new_turn.correct?
  end

  def test_counting_turns
    new_turn = @round.take_turn("Juneau")

    assert_equal new_turn, @round.turns
    assert_equal 1, @round.number_correct
  end

  def test_next_turn_different_card
    @round.take_turn("Juneau")

    assert_equal @card_2, @round.current_card

    @round.take_turn("Venus")

    assert_equal 2, @round.number_correct
    assert_equal "Incorrect.", @round.turns.last.feedback
    assert_equal 1, @round.number_correct
  end

end



# round.number_correct_by_category(:Geography)
# #=> 1
#
# round.number_correct_by_category(:STEM)
# #=> 0
#
# round.percent_correct
# #=> 50.0
#
# round.percent_correct_by_category(:Geography)
# #=> 100.0
#
# pry(main)> round.current_card
# #=> #<Card:0x00007fa161a136f0 @answer="North north west", @question="Describe in words the exact direction that is 697.5° clockwise from due north?", @category=:STEM>
