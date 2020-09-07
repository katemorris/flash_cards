require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require './lib/card'

class TurnTest < Minitest::Test

  def test_it_exists
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    turn = Turn.new("Juneau", card)
    assert_instance_of Turn, turn
  end

  def test_it_can_use_a_card
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    turn = Turn.new("Juneau", card)
    assert_equal card, turn.card
  end

  def test_a_correct_guess_and_feedback
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    turn = Turn.new("Juneau", card)
    turn.card
    assert_equal "Juneau", turn.guess
    assert turn.correct?
    assert_equal "Correct!", turn.feedback
  end

  def test_an_incorrect_guess_and_feedback
    card = Card.new("Which planet is closest to the sun?", "Mercury", :STEM)
    turn = Turn.new("Saturn", card)
    turn.card
    assert_equal "Saturn", turn.guess
    assert_equal false, turn.correct?
    assert_equal "Incorrect.", turn.feedback
  end
end
