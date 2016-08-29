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
		@tracks.length.times do |index|
			return true if name == @tracks[index].get_name
		end
		false
	end

	def add_track track
		@tracks.push(track)
	end

	def list_tracks_by artist # Class: Artist
		# search by artist's name
		list = []
		@tracks.each do |track|
			list.push(track) if track.get_artist.get_name == artist.get_name
		end
		list
	end

	# methods for artists
	def artists_id_contains id
		@artists.length.times do |index|
			return true if id == @artists[index].get_id
		end
		false
	end

	def artists_contains name
		@artists.length.times do |index|
			return true if name == @artists[index].get_name
		end
		false
	end

	def add_artist artist
		@artists.push(artist)
	end

	# methods for playlist
	
end