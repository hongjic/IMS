class Track

	def initialize name,artist,id
		@name = name
		@artist = artist
		@id = id
		@times = 0
		@lastplayed = "Not played yet."
	end

	def play
		@times = @times + 1
		@lastplayed = Time.now.strftime("%Y-%m-%d %H:%M:%S")
	end

	def info
		res = "No: #{@id}\nTrakname: #{@name}\nArtist: #{@artist.get_name}\nPlayed times: #{@times}"
		res += "\nLast time played: #{@lastplayed}" if @times >0
		res
	end

	def brief_info
		"No.#{@id} #{@name}"
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

	def get_lastplayed
		@lastplayed
	end
end
