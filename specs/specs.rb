require 'minitest/autorun'
require 'minitest/reporters'
require '../app/card'
require '../app/deck'
require '../app/player'

Minitest::Reporters.use!

class CardTest < Minitest::Test

	def setup
		@test_card = Card.new(10, :clubs)
		@test_card2 = Card.new(10, :clubs, :king)
		@test_deck = Deck.new()
		@test_deck2 = Deck.new()
		@test_player = Player.new("Iggy")
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

	# Player Class

	def test_player_exists
		assert_instance_of Player, @test_player
	end

	def test_player_has_name
		expected = "Iggy"
		actual = @test_player.player_name
		assert_equal(expected, actual)
	end

	def test_player_has_hand
		expected = []
		actual = @test_player.player_hand
		assert_equal(expected, actual)
	end

end