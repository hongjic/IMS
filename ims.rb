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
		puts "wellcome to IMS"
		while (true)
			print "> "
			text = gets
			puts  "Your last command was #{text}"
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
				when "add_track"
					puts add_track(command[1], command[2])
				when "add_artist"
					puts add_artist(command[1])
				when "info_track"
					puts info_track(command[1])
				when "info_artist"
					puts info_artist(command[1])
				when "play_track"
					puts play_tack(command[1])
				when "count_tracks_by"
					puts count_tracks_by(command[1])
				when "list_tracks_by"
					puts list_tracks_by(command[1])
				end
			end
		end
	end

	def exit_ims
		@storage.save_to_disk
		exit
	end

	def help
		puts "exit - save state and exit.",
			"info - display a high level summary of the state.",
			"info track - Display info about a certain track by number",
			"info artist - Display info about a certain artist, by id",
			"add artist - Adds a new artist to storage and assign an artist id",
			"add track - Add a new track to storage",
			"play track - Record that an existing track was played at the current time",
			"count tracks - Display how many tracks are known by a certain artist",
			"list tracks - Display the tracks played by a certain artist" 
	end

	def info
		# the last 3 tracks played
		len_of_playlist = @storage.playlist.length
		len_of_playlist = 3 if len_of_playlist>3
		if len_of_playlist > 0
			puts "The last #{len_of_playlist} tracks played are:"
		else
			puts "No trakcs played yet."
		end
		len_of_playlist.times do |index|
			if index<len_of_playlist-1
				print @storage.playlist[index].get_name+", " 
			else
				puts @storage.playlist[index].get_name
			end
		end

		# total number of tracks
		puts "The total number of tracks are: #{@storage.tracks.length}"

		# total number of artists
		puts "The total number of artists are: #{@storage.artists.length}"
	end

	def add_track trackname, artistid
		return "Trackname already exists." if @storage.track_contains trackname
		artist = @storage.artist_id_contains artistid
		return "There is no such artist" if !artist
		@storage.add_track Track.new(trackname, artist)
		"Add track success."
	end

	def add_artist artistname
		return "Artistname already exists." if @storage.artists_contains artistname
		@storage.add_artist Artist.new(artistname)
		"Add artist success."
	end

	def info_track trackname
		track = @storage.track_contains trackname
		return "There is no such track." if !track
		track.info
	end

	def info_artist artistid
		artist = @storage.artist_id_contains artistid
		return "There is no such artist." if !artist
		artist.info
	end

	def play_track trackname
		track = @storage.track_contains trackname
		return "There is no such track." if !trackname
		track.play
		"Play #{trackname}."
	end

	def count_tracks_by artistid
		artist = @storage.artist_id_contains artistid
		return "There is no such artist." if !artist
		sum = @storage.count_tracks_by artist
		"#{sum} tracks are known by #{artistid}"
	end

	def list_tracks_by artistid
		artist = @storage.artist_id_contains artistid
		return "There is no such artist." if !artist
		res = ""
		@storage.list_tracks_by(artist).each do |track|
			res += track.get_name + "\n"
		end
		res
	end
end