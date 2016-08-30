require 'rspec'
require_relative '../Command'

describe Command do
	
	it "Command <clear> matches correctly" do
		expect(Command.interpret(" clear  \n")).to eq ["clear"]
	end

	it "Command <exit> matches correctly" do
		expect(Command.interpret(" exit \n")).to eq ["exit_ims"]
	end

	it "Command <help> matches correctly" do
		expect(Command.interpret(" help \n")).to eq ["help"]
	end

	it "Command <info> matches correctly" do
		expect(Command.interpret(" info \n")).to eq ["info"]
	end

	it "Command <all tracks> matches correctly" do
		expect(Command.interpret(" all tracks \n")).to eq ["all_tracks"]
	end

	it "Command <all artists> matches correctly" do
		expect(Command.interpret(" all artists \n")).to eq ["all_artists"]
	end

	it "Command <add track> matches correctly" do
		expect(Command.interpret(" add track \"hahaha\" by \"chj\" \n")).to eq ["add_track", "hahaha", "chj"]
	end

	it "Command <add artist> matches correctly" do
		expect(Command.interpret("add artist \"chen hong ji\"\n")).to eq ["add_artist", "chen hong ji"]
	end

	it "Command <info track> matches correctly" do
		expect(Command.interpret("info track \"3\" \n")).to eq ["info_track", "3"]
	end	

	it "Command <info artist> matches correctly" do
		expect(Command.interpret("info artist \"chj\" \n")).to eq ["info_artist", "chj"]
	end	

	it "Command <play track> matches correctly" do
		expect(Command.interpret("play track \"3\" \n")).to eq ["play_track", "3"]
	end	
	
	it "Command <count tracks> matches correctly" do
		expect(Command.interpret("count tracks by \"chj\" \n")).to eq ["count_tracks_by", "chj"]
	end	
	
	it "Command <list tracks> matches correctly" do
		expect(Command.interpret("list tracks by \"chj\" \n")).to eq ["list_tracks_by", "chj"]
	end	
	
	it "Command <command wrong> matches correctly" do
		expect(Command.interpret("command XX \n")).to be false
	end

end