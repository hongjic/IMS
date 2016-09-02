class Track

	def initialize name,artistid,id
		@name = name
		@artistid = artistid
		@id = id
		@times = 0
		@lastplayed = "Not played yet."
	end

	def play
		@times = @times + 1
		@lastplayed = Time.now.strftime("%Y-%m-%d %H:%M:%S")
	end

	def info
		res = "No: #{@id}\nTrakname: #{@name}\nArtistId: #{@artistid}\nPlayed times: #{@times}"
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

	def get_artistid
		@artistid
	end	

	def get_lastplayed
		@lastplayed
	end
end
