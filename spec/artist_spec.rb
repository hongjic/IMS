require 'rspec'
require_relative '../Artist'

describe Artist do
	
	before {
		@storage = Storage.instance
		@storage.clear
		@storage.artists.push(Artist.new("chen hong ji"))
	}

	it "should create id by default(initial words) correctly" do
		expect(Artist.new("liu yi fei").get_id).to eq "lyf"
	end

	it "should use name as id when default id (initial words) already exist" do
		expect(Artist.new("chen huang ji").get_id).to eq "chen huang ji"
	end
end