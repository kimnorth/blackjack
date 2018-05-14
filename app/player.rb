class Player

	attr_accessor :player_name, :player_hand

	def initialize(player_name)
		@player_name = player_name
		@player_hand = []
	end

end