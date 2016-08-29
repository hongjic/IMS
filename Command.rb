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
			return "exit"
		when /\A ?help ?\z/
			return "help"
		when /\A ?info ?\z/
			return "info"
		when /\A ?add track "[^"]+" by "[^"]+"\z/
			command = ["add_track"] + extract(text)
		when /\A ?add artist "[^"]+"\z/
			command = ["add_artist"] + extract(text)
		when 
		else
			return "command wrong"
	end
end
