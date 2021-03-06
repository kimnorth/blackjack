require 'minitest/autorun'
require 'minitest/reporters'
require '../app/card'
require '../app/deck'
require '../app/player'
require '../app/game_logic'

Minitest::Reporters.use!

class CardTest < Minitest::Test

	def setup
		# Cards
		@test_card = Card.new(10, :clubs)
		@test_card2 = Card.new(10, :clubs, :king)
		@six_of_diamonds = Card.new(6, :diamonds)
		@six_of_hearts = Card.new(6, :hearts)
		@king_spade_card = Card.new(10, :spade, :king)
		@queen_hearts_card = Card.new(10, :hearts, :queen)
		@jack_diamonds_card = Card.new(10, :diamonds, :jack)
		@ace_clubs_card = Card.new(11, :clubs, :ace)
		@ace_spades_card = Card.new(11, :spades, :ace)
		@ace_diamonds_card = Card.new(11, :diamonds, :ace)
		# Deck
		@test_deck = Deck.new()
		@test_deck2 = Deck.new()
		@test_deck3 = Deck.new()
		# Player
		@test_player = Player.new("Iggy")
		# Logic
		@game_logic = GameLogic.new([], Deck.new())
		@game_logic2 = GameLogic.new(
			[
				Player.new("Ted"), 
				Player.new("Steve")
			],
			Deck.new()
		)
		@game_logic3 = GameLogic.new(
			[	
				Player.new("Alan"),
				Player.new("Chris")
			],
			Deck.new()
		)
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

	def test_deck_setup_populates_remaining_cards
		@test_deck3.setup_deck()
		expected = 52
		actual = @test_deck3.remaining_cards.length
		assert_equal(expected, actual)
	end

	def test_can_draw_random_card_from_deck
		@test_deck3.setup_deck()
		actual = @test_deck3.draw_card()
		assert_instance_of Card, actual
	end

	def test_drawing_card_reduces_size_of_remaining_cards
		@test_deck3.setup_deck()
		@test_deck3.draw_card()
		expected = 51
		actual = @test_deck3.remaining_cards.length
		assert_equal(expected, actual)
	end

	def test_if_no_remaining_cards_deck_resets
		@test_deck3.draw_card()
		expected = 51
		actual = @test_deck3.remaining_cards.length
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

	def test_player_hand_can_contain_card
		@test_player.player_hand.push(@test_card)
		expected = @test_card
		actual = @test_player.player_hand.first
		assert_equal(expected, actual)
	end

	def test_player_can_have_score
		@test_player.score = 1
		expected = 1
		actual = @test_player.score
		assert_equal(expected, actual)
	end

	# GameLogic Class

	def test_game_logic_exists
		assert_instance_of GameLogic, @game_logic
	end

	def test_game_can_take_players
		expected = []
		actual = @game_logic.players
		assert_equal(expected, actual)
	end

	def test_game_has_players
		actual = @game_logic2.players.first
		assert_instance_of Player, actual
	end

	def test_game_has_game_count
		expected = 0
		actual = @game_logic2.game_count
		assert_equal(expected, actual)
	end

	def test_game_has_deck
		actual = @game_logic2.deck
		assert_instance_of Deck, actual
	end

	def test_game_can_add_card_to_player_hand
		@game_logic2.add_card_to_player(@king_spade_card, @game_logic2.players.first)
		expected = @king_spade_card
		actual = @game_logic2.players.first.player_hand[0]
		assert_equal(expected, actual)
	end

	def test_game_can_deal_first_hand_to_players
		@game_logic3.deal_hand()
		actual = @game_logic3.players.first.player_hand[0]
		assert_instance_of Card, actual
	end

	def test_game_deals_two_cards_to_each_player
		@game_logic3.deal_hand()
		expected = 4
		actual = 0
		@game_logic3.players.each do |player|
			actual += player.player_hand.length
		end
		assert_equal(expected, actual)
	end

	def test_game_can_add_up_value_of_hand_with_number_cards
		@game_logic3.add_card_to_player(@six_of_diamonds, @game_logic3.players.first)
		@game_logic3.add_card_to_player(@six_of_hearts, @game_logic3.players.first)
		expected = 12
		actual = @game_logic3.add_up_player_hand(@game_logic3.players.first)
		assert_equal(expected, actual)
	end

	def test_game_can_add_up_value_of_hand_with_face_cards
		@game_logic3.add_card_to_player(@king_spade_card, @game_logic3.players.first)
		@game_logic3.add_card_to_player(@queen_hearts_card, @game_logic3.players.first)
		expected = 20
		actual = @game_logic3.add_up_player_hand(@game_logic3.players.first)
		assert_equal(expected, actual)
	end

	def test_game_can_switch_first_ace_to_lower_value_if_over_21
		@game_logic3.add_card_to_player(@king_spade_card, @game_logic3.players.first)
		@game_logic3.add_card_to_player(@queen_hearts_card, @game_logic3.players.first)
		@game_logic3.add_card_to_player(@ace_clubs_card, @game_logic3.players.first)
		expected = 21
		actual = @game_logic3.add_up_player_hand(@game_logic3.players.first)
		assert_equal(expected, actual)
	end

	def test_game_can_switch_to_lower_ace_with_multiple_aces
		@game_logic3.add_card_to_player(@ace_clubs_card, @game_logic3.players.first)
		@game_logic3.add_card_to_player(@ace_spades_card, @game_logic3.players.first)
		@game_logic3.add_card_to_player(@ace_diamonds_card, @game_logic3.players.first)
		expected = 13
		actual = @game_logic3.add_up_player_hand(@game_logic3.players.first)
		assert_equal(expected, actual)
	end

	def test_game_can_determine_if_player_if_not_bust
		@game_logic3.deal_hand()
		expected = false
		actual = @game_logic3.check_for_bust(@game_logic3.players.first)
		assert_equal(expected, actual)
	end

	def test_game_can_determine_if_player_bust
		@game_logic3.deal_hand()
		@game_logic3.add_card_to_player(@king_spade_card, @game_logic3.players.first)
		@game_logic3.add_card_to_player(@queen_hearts_card, @game_logic3.players.first)
		expected = true
		actual = @game_logic3.check_for_bust(@game_logic3.players.first)
		assert_equal(expected, actual)
	end

end