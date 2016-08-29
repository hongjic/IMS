#require "byebug" #standard library
require_relative "Storage"
require_relative "Artist"
require_relative "Track"
require_relative "Command"

class IMS

	def initialize
		@storage = Storage.instance
		@storage.read_from_disk
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
				case command[0]
				when "exit"
					exit_ims
				when "help"
					help
				when "info"
					info
				when "clear"
					puts clear
				when "all_tracks"
					puts all_tracks
				when "all_artists"
					puts all_artists
				when "add_track"
					puts add_track(command[1], command[2])
				when "add_artist"
					puts add_artist(command[1])
				when "info_track"
					puts info_track(command[1])
				when "info_artist"
					puts info_artist(command[1])
				when "play_track"
					puts play_track(command[1])
				when "count_tracks_by"
					puts count_tracks_by(command[1])
				when "list_tracks_by"
					puts list_tracks_by(command[1])
				end
			end
		end
	end

	def clear
		@storage.clear
		"Storage cleared"
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
	end

	def all_artists
		res = ""
		@storage.artists.each { |artist| res += "Id: #{artist.get_id}  Name: #{artist.get_name}\n"}
		res += "Altogether #{@storage.artists.length} artists."
	end

	def add_track trackname, artistid
		return "Trackname already exists." if @storage.tracks_contains trackname
		artist = @storage.artists_id_contains artistid
		return "There is no such artist" if !artist
		id = @storage.tracks.length
		@storage.add_track Track.new(trackname, artist, id)
		"Add track success."
	end

	def add_artist artistname
		return "Artistname already exists." if @storage.artists_contains artistname
		@storage.add_artist Artist.new(artistname)
		"Add artist success."
	end

	def info_track trackid
		return "Trackid illegal." unless trackid.match(/\A[0-9]+\z/)
		id = trackid.to_i
		return "There is no track No.#{id}." if id >= @storage.tracks.length
		track = @storage.tracks[id]
		track.info
	end

	def info_artist artistid
		artist = @storage.artists_id_contains artistid
		return "There is no such artist." if !artist
		artist.info
	end

	def play_track trackid
		return "Trackid illegal." unless trackid.match(/\A[0-9]+\z/)
		id = trackid.to_i
		return "There is no track No.#{id}." if id >= @storage.tracks.length
		track = @storage.tracks[id]
		track.play
		@storage.add_to_playlist track 
		"Play track No.#{id} #{track.get_name} at time<#{track.get_lastplayed}>"
	end

	def count_tracks_by artistid
		artist = @storage.artists_id_contains artistid
		return "There is no such artist." if !artist
		sum = @storage.count_tracks_by artist
		"#{sum} tracks are known by #{artistid}"
	end

	def list_tracks_by artistid
		artist = @storage.artists_id_contains artistid
		return "There is no such artist." if !artist
		res = ""
		count = 1
		@storage.list_tracks_by(artist).each do |track|
			res += count.to_s + ". " + track.get_name + "\n"
			count += 1
		end
		if res == "" 
			return "There is no tracks by #{artist.get_name} yet."
		else 
			return res
		end
	end
end