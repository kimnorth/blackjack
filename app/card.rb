class Card

	attr_reader :suit, :face_character
	attr_accessor :face_value

	def initialize(face_value, suit, face_character=nil)
		@face_value = face_value
		@suit = suit
		@face_character = face_character
	end

end