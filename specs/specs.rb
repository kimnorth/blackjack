require 'minitest/autorun'
require '../app/card'

class CardTest < Minitest::Test

	def setup
		@test_card = Card.new(10, :clubs)
		@test_card2 = Card.new(10, :clubs, :king)
	end

	def test_card_exists
		assert_instance_of Card, @test_card
	end

	def test_card_has_value
		expected = 10
		actual = @test_card.face_value
		assert_equal(expected, actual)
	end

	def test_card_has_suit
		expected = :clubs
		actual = @test_card.suit
		assert_equal(expected, actual)
	end

	def test_card_has_face
		expected = :king
		actual = @test_card2.face_character
		assert_equal(expected, actual)
	end

end