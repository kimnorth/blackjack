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
		@players.each do |player|
			player.player_hand.push(@deck.draw_card())
			player.player_hand.push(@deck.draw_card())
		end
	end

	def add_up_player_hand(player)
		total_value = 0

		player.player_hand.each do |card|
			total_value += card.face_value
		end
		# convert first ace to one if hand is over 21
		
		player.player_hand.each do |card|
			if(total_value > 21 && card.face_value == 11)
				card.face_value = 1
				total_value -= 10
			end
		end

		return total_value
	end

end