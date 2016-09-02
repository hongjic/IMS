#require "byebug" #standard library
require_relative "Storage"
require_relative "Artist"
require_relative "Track"
require_relative "Command"

class IMS

	def initialize
		@storage = Storage.instance
	end

	def run 
		puts "Wellcome to IMS.",
			"You can use 'help' to browse all available commands.",
			"Notice that notes(\"keyword\") are required when you type in keywords."
		while (true)
			print "> "
			text = gets
			# puts  "Your last command was #{text}"
			#byebug
			if false == command = Command.interpret(text) 
				puts "command wrong"
			else 
				case command.length
				when 1
					eval(command[0])
				when 2
					eval(command[0] + "(\"" + command[1] + "\")")
				when 3
					eval(command[0] + "(\"" + command[1] + "\", \"" + command[2] + "\")")
				end
			end
		end
	end

	def fetch_data
		@storage.read_from_disk
	end

	def clear
		@storage.clear
		puts "Storage cleared"
	end

	def exit_ims
		@storage.save_to_disk
		exit
	end

	def help
		puts "  exit         - Save state and exit",
			"  info         - Display a high level summary of the state",
			"  all tracks   - Display all tracks information",
			"  all artists  - Display all artists information",
			"  info track   - Display info about a certain track by number",
			"                 usage: info track \"trackid\"  ",
			"  info artist  - Display info about a certain artist, by id",
			"                 usage: info artist \"artistid\"",
			"  add artist   - Adds a new artist to storage and assign an artist id",
			"                 usage: add artist \"artistname\"",
			"  add track    - Add a new track to storage",
			"                 usage: add track \"trackname\" by \"artistid\"",
			"  play track   - Record that an existing track was played at the current time",
			"                 usage: play track \"trackid\"",
			"  count tracks - Display how many tracks are known by a certain artist",
			"                 usage: count tracks by \"artistid\"",
			"  list tracks  - Display the tracks played by a certain artist" ,
			"                 usage: list tracks by \"artistid\"",
			"  clear        - Clear all data"
	end

	def info
		# the last 3 tracks played
		len_of_playlist = @storage.playlist.length
		if len_of_playlist > 0
			puts "The last #{len_of_playlist} tracks played are:"
		else
			puts "No tracks played yet."
		end
		count = 1
		@storage.playlist.each do |track|
			puts count.to_s + ". " + track.get_name
			count += 1
		end

		# total number of tracks
		puts "The total number of tracks are: #{@storage.tracks.length}"

		# total number of artists
		puts "The total number of artists are: #{@storage.artists.length}"
	end

	def all_tracks
		res = ""
		@storage.tracks.each { |track| res += track.brief_info + "\n" }
		res += "Altogether #{@storage.tracks.length} tracks."
		puts res
	end

	def all_artists
		res = ""
		@storage.artists.each { |id, artist| res += "Id: #{id}  Name: #{artist.get_name}\n"}
		res += "Altogether #{@storage.artists.size} artists."
		puts res
	end

	def add_track trackname, artistid
		if @storage.tracks_contains trackname 
			puts "Trackname already exists."
			return 
		end
		unless @storage.artists_id_contains artistid 
			puts "There is no such artist."
			return
		end
		id = @storage.tracks.length
		@storage.add_track Track.new(trackname, artistid, id)
		puts "Add track success."
	end

	def add_artist artistname
		if @storage.artists_contains artistname
			puts "Artistname already exists."
			return
		end
		@storage.add_artist Artist.new(artistname)
		puts "Add artist success."
	end

	def info_track trackid
		unless trackid.match(/\A[0-9]+\z/)
			puts "Trackid illegal."
			return
		end		
		id = trackid.to_i
		if id >= @storage.tracks.length
			puts "There is no track No.#{id}."
			return
		end
		track = @storage.tracks[id]
		puts track.info
	end

	def info_artist artistid
		unless @storage.artists_id_contains artistid
			puts "There is no such artist."
			return
		end
		puts @storage.artists[artistid].info
	end

	def play_track trackid
		unless trackid.match(/\A[0-9]+\z/)
			puts "Trackid illegal"
			return
		end		
		id = trackid.to_i
		if id >= @storage.tracks.length
			puts "There is no track No.#{id}."
			return
		end
		track = @storage.tracks[id]
		track.play
		@storage.add_to_playlist track 
		puts "Play track No.#{id} #{track.get_name} at time<#{track.get_lastplayed}>"
	end

	def count_tracks_by artistid
		unless @storage.artists_id_contains artistid
			puts "There is no such artist."
			return
		end 
		sum = @storage.count_tracks_by artistid
		puts "#{sum} tracks are known by #{artistid}"
	end

	def list_tracks_by artistid
		unless @storage.artists_id_contains artistid
			puts "There is no such artist."
			return
		end
		res = ""
		count = 1
		@storage.list_tracks_by(artistid).each do |track|
			res += count.to_s + ". " + track.get_name + "\n"
			count += 1
		end
		if res == "" 
			puts "There is no tracks by #{artist.get_name} yet."
			return
		end
		puts res
	end
end