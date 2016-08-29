require_relative "Storage"

class Artist

	def initialize(name)
		@name = name
		generate_id
	end

	def info
		"Artistname: #{@name}\n Id: #{@id}"
	end

	def generate_id
		arr = @name.split(' ')
		id = ""
		arr.size.times do |i|
			id += arr[i][0]
		end
		storage = Storage.instance
		if storage.artists_id_contains id 
			id = @name
		end
		@id = id
	end

	def get_name
		@name
	end

	def get_id
		@id
	end
end