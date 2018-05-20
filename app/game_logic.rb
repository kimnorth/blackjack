class GameLogic

	attr_reader :players, :game_count, :deck

	def initialize(players, deck)
		@players = players
		@deck = deck
		@game_count = 0
	end

end