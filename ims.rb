#require "byebug" #standard library

class Track 
	attr_accessor :name
	attr_accessor :artist

	def initialize(_name, _artist)
		@name = _name
		@artist = _artist
	end

	def to_s
		return "Track #{name} by #{artist}" 
	end
end

class Artist
	attr_accessor :name
	attr_accessor :id

	def initialize(_name)
		@name = _name
		generate_id(name)
	end
	def generate_id
		@id = @name
end

class PlayList
	attr_accessor :tracks

	def initialize
		tracks = []
	end
	def add_to_playlist(track)
		tracks.add(track)
		if (tracks.length>3)
			tracks.shift()
	end
end

class State
	attr_accessor :playlist
	def initialize

	end
	def save_to_disk
	end
	def read_from_disk
	end
end


class IMS
	def initialize
		@current_state = State.new
		# a = []
		# a[0] = Track.new
		# a[0].name = "Let it Be"
		# a[0].artist = "The Beatles"
	end

	def run 
		puts "wellcome to IMS"
		while (true)
			print "> "
			command = gets
			puts  "Your last command was #{command}"
			#byebug
			case command
			when "exit\n"
				exit_ims
			when "help\n", "info\n", "info track\n", "info artist\n", "add artist\n",
				"add track\n", "play track\n", "count tracks\n", "list tracks\n"
				eval(command)
			else 
				puts "no such command"
			end
		end
	end

	def exit_ims
		@current_state.save_to_disk
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
end

i = IMS.new
i.run





###############################
# require 'yaml/store'
# store = PStore.new('store.pstore')
# data = store.transaction do
# 	store[:name] = "Brandeis"
# 	store[:town] = "Waltham"
# 	store.commit	
# end