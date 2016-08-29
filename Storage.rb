require 'yaml/store'
require 'singleton'

class Storage

	include Singleton

	attr_accessor :playlist
	attr_accessor :artists
	attr_accessor :tracks

	@@store = PStore.new('storage.pstore')

	# methods for data persistency
	def save_to_disk
		@@store.transaction do
			@@store["artists"] = @artists
			@@store["tracks"] = @tracks
			@@store["playlist"] = @playlist
			@@store.commit
		end
	end

	def read_from_disk
		@@store.transaction(true) do
			@artists = @@store["artists"] || Array.new
			@tracks = @@store["tracks"] || Array.new
			@playlist = @@store["playlist"] || Array.new
		end
		puts "Data Loading Complete"
	end

	# methods for tracks
	def track_contains name
		false
	end

	def add_track track
	end

	def list_tracks_by artist # Class: Artist
	end

	# methods for artists
	def artists_id_contains id
	end

	def artists_contains name
	end

	def add_artist name
	end

	# methods for playlist
	def get_playlist
	end

	def play_track track
	end

end