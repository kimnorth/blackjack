class Player

	attr_accessor :player_name, :player_hand, :score

	def initialize(player_name)
		@player_name = player_name
		@player_hand = []
		@score = 0
	end

end