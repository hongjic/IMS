# interpret the command

class Command

	def self.extract text
		arr = []
		text.scan(/"[^"]+"/) do |st|
			len = st.length
			arr.push(st[1,len-2])
		end
		arr
	end

	def self.interpret text
		text = text.gsub(/ +/, ' ')
		case text
		when /\A ?clear ?\n\z/
			["clear"]
		when /\A ?exit ?\n\z/
			["exit_ims"]
		when /\A ?help ?\n\z/
			["help"]
		when /\A ?info ?\n\z/
			["info"]
		when /\A ?all tracks ?\n\z/
			["all_tracks"]
		when /\A ?all artists ?\n\z/
			["all_artists"]
		when /\A ?add track "[^"]+" by "[^"]+" ?\n\z/
			["add_track"] + extract(text)
		when /\A ?add artist "[^"]+" ?\n\z/
			["add_artist"] + extract(text)
		when /\A ?info track "[^"]+" ?\n\z/
			["info_track"] + extract(text)
		when /\A ?info artist "[^"]+" ?\n\z/
			["info_artist"] + extract(text)
		when /\A ?play track "[^"]+" ?\n\z/
			["play_track"] + extract(text)
		when /\A ?count tracks by "[^"]+" ?\n\z/
			["count_tracks_by"] + extract(text)
		when /\A ?list tracks by "[^"]+" ?\n\z/
			["list_tracks_by"] + extract(text)
		else
			false
		end
	end
end