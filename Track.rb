class Track
	def initialize name,artist
		@name = name
		@artist = artist
		@times = 0
	end

	def play
		@times = @times + 1
	end

	def info
		"Trakname: #{@name}\nArtist: #{@artist.get_name}\nPlayed times: #{@times}"
	end

	def get_times
		@times
	end

	def get_name 
		@name
	end

	def get_artist
		@artist
	end	
end
