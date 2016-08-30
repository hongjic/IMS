require "rspec"
require_relative "../Storage"
require_relative "../Artist"
require_relative "../Track"

describe Storage do 

	before {
		@storage = Storage.instance
		@storage.clear
		@chj = Artist.new("chen hong ji")
		@lyf = Artist.new("liu yi fei")
		@storage.artists = [@chj, @lyf]
		@track_ha = Track.new("hahaha", @chj, 0)
		@track_ha.play
		@storage.tracks.push(@track_ha)
		@storage.add_to_playlist(@track_ha)
	}

	it "method <clear> runs correctly" do
		@storage.clear
		expect(@storage.artists.length).to eq 0
		expect(@storage.tracks.length).to eq 0
		expect(@storage.playlist.length).to eq 0
		expect(@storage.playtime.length).to eq 0
	end

	it "method <tracks_contains> runs correctly" do
		expect(@storage.tracks_contains("hahaha")).not_to be false
		expect(@storage.tracks_contains("hahah")).to be false
	end

	it "method <list_tracks_by> runs correctly" do
		expect(@storage.list_tracks_by(@chj)).to eq [@track_ha]
	end

	it "method <count_tracks_by> runs correctly" do
		expect(@storage.count_tracks_by(@lyf)).to eq 0
		expect(@storage.count_tracks_by(@chj)).to eq 1
	end

	it "method <artists_id_contains> runs correctly" do
		expect(@storage.artists_id_contains("chj")).not_to be false
		expect(@storage.artists_id_contains("lyf")).not_to be false
		expect(@storage.artists_id_contains("chen hong ji")).to be false
	end

	it "method <artists_contains> runs correctly" do
		expect(@storage.artists_contains("chen hong ji")).not_to be false
		expect(@storage.artists_contains("liu yi fei")).not_to be false
		expect(@storage.artists_contains("chj")).to be false
	end

	it "method <add_to_playlist> runs correctly" do
		new_track = Track.new("hahaha2", @lyf, 1)
		new_track.play
		@storage.add_to_playlist(new_track)
		expect(@storage.playtime).to eq [new_track.get_lastplayed, @track_ha.get_lastplayed]
	end

end