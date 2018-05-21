class GameLogic

	attr_reader :players, :game_count, :deck

	def initialize(players, deck)
		@players = players
		@deck = deck
		@game_count = 0
	end

	def add_card_to_player(card, player)
		@players.each do |i|
			if (i == player)
				i.player_hand.push(card)
			end
		end
	end

	def deal_hand
		# Get how many players are in the game

		@players.each do |player|
			player.player_hand.push(@deck.draw_card()) * 2
		end
		
	end

end