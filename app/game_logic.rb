class GameLogic

	attr_reader :players, :game_count

	def initialize(players)
		@players = players
		@game_count = 0
	end

end