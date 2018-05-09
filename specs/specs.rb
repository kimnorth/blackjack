require 'minitest/autorun'
require '../app/card'

class CardTest < Minitest::Test

	def setup
		@test_card = Card.new()
	end

	def test_card_exists
		assert_instance_of Card, @test_card
	end

	def test_card_has_value
		expected = 10
		actual = @test_card.value
	end

end