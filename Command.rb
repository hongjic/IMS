# interpret the command

class Command

	def self.extract text
		arr = []
		text.scan(/"[^"]+"/) do |st|
			arr.push(st)
		end
		arr
	end

	def self.interpret text
		text = text.gsub(/ +/, ' ')
		case text
		when /\A ?exit ?\z/
			["exit"]
		when /\A ?help ?\z/
			["help"]
		when /\A ?info ?\z/
			["info"]
		when /\A ?add track "[^"]+" by "[^"]+" ?\z/
			command = ["add_track"] + extract(text)
		when /\A ?add artist "[^"]+" ?\z/
			command = ["add_artist"] + extract(text)
		when /\A ?info track "[^"]+" ?\z/
			command = ["info_track"] + extract(text)
		when /\A ?info artist "[^"]+" ?\z/
			command = ["info_artist"] + extract(text)
		when /\A ?play track "[^"]+" ?\z/
			command = ["play_track"] + extract(text)
		when /\A ?count tracks by "[^"]+" ?\z/
			command = ["count_tracks_by"] + extract(text)
		when /\A ?list tracks by "[^"]+" ?\z/
			command = ["list_tracks_by"] + extract(text)
		else
			false
	end
end