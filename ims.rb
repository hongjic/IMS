#require "byebug" #standard library
require_relative "Storage"
require_relative "Artist"
require_relative "Track"

class IMS

	def initialize
		@storage = Storage.instance
		@storage.read_from_disk
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
	end
end