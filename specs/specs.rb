require 'minitest/autorun'
require '../app/card'
require '../app/deck'

class CardTest < Minitest::Test

	def setup
		@test_card = Card.new(10, :clubs)
		@test_card2 = Card.new(10, :clubs, :king)
		@test_deck = Deck.new()
		@test_deck2 = Deck.new()
	end

	# Card Class

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

	# Deck Class

	def test_deck_exists
		assert_instance_of Deck, @test_deck
	end

	def test_deck_has_card_container
		expected = []
		actual = @test_deck.remaining_cards
		assert_equal(expected, actual)
	end

	def test_deck_can_contain_cards
		@test_deck2.remaining_cards.push(@test_card)
		expected = @test_card
		actual = @test_deck2.remaining_cards.first
		assert_equal(expected, actual)
	end

end