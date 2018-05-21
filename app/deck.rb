class Deck

	attr_reader :remaining_cards

	def initialize
		@remaining_cards = []
	end

	def setup_deck
		# Create 4 x cards for each suits
		
		@remaining_cards.push(
			Card.new(11, :spades, :ace),
			Card.new(11, :diamonds, :ace),
			Card.new(11, :clubs, :ace),
			Card.new(11, :hearts, :ace),
		)
		
		# Creates the first 40

		i = 2

		while i < 11
			@remaining_cards.push(
				Card.new(i, :spades),
				Card.new(i, :diamonds),
				Card.new(i, :clubs),
				Card.new(i, :hearts),
			)
			i += 1
		end

		# Creates face cards

		face_cards = [:jack, :queen, :king]

		face_cards.each	do |character|
			@remaining_cards.push(
				Card.new(10, :spades, character),
				Card.new(10, :diamonds, character),
				Card.new(10, :clubs, character),
				Card.new(10, :hearts, character)
			)
		end

	end

	def draw_card
		if remaining_cards.length == 0
			setup_deck()
		end
		remaining_cards_array_length = @remaining_cards.length
		number = rand(1...remaining_cards_array_length)
		drawn_card = @remaining_cards[number]
		@remaining_cards.delete_at(number)
		return drawn_card
	end

end