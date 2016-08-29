require 'yaml/store'
require 'singleton'

class Storage

	include Singleton

	attr_accessor :playlist
	attr_accessor :artists
	attr_accessor :tracks
	attr_accessor :playtime

	@@history_max = 3
	@@store = PStore.new('storage.pstore')

	def clear
		@playlist = []
		@artists = []
		@tracks = []
		@playtime = []
	end

	# methods for data persistency
	def save_to_disk
		@@store.transaction do
			@@store["artists"] = @artists
			@@store["tracks"] = @tracks
			@@store["playlist"] = @playlist
			@@store["playtime"] = @playtime
			@@store.commit
		end
	end

	def read_from_disk
		@@store.transaction(true) do
			@artists = @@store["artists"] || Array.new
			@tracks = @@store["tracks"] || Array.new
			@playlist = @@store["playlist"] || Array.new
			@playtime = @@store["playtime"] || Array.new
		end
		puts "Data Loading Complete"
	end

	# methods for tracks
	def tracks_contains name
		@tracks.length.times do |index|
			return @tracks[index] if name == @tracks[index].get_name
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
			list.push(track) if track.get_artist.get_id == artist.get_id
		end
		list
	end

	def count_tracks_by artist 
		sum = 0
		@tracks.each do |track|
			sum = sum+1 if track.get_artist.get_id == artist.get_id
		end
		sum
	end

	# methods for artists
	def artists_id_contains id
		@artists.length.times do |index|
			return @artists[index] if id == @artists[index].get_id
		end
		false
	end

	def artists_contains name
		@artists.length.times do |index|
			return artists[index] if name == @artists[index].get_name
		end
		false
	end

	def add_artist artist
		@artists.push(artist)
	end

	# methods for playlist
	def add_to_playlist track
		@playlist.unshift(track)
		@playtime.unshift(track.get_lastplayed)
		if @playlist.length > @@history_max
			@playlist.pop
			@playtime.pop
		end
	end
	
end