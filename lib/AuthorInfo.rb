# https://github.com/augustl/net-http-cheat-sheet
# http://developer.yahoo.com/ruby/ruby-json.html
# http://www.mediawiki.org/wiki/API:Tutorial

require "net/http"
require "uri"
require "json"

module AuthorInfo

	def self.getInfo(name)
		
		# format user input => replace spaces with underscores
		# sub replaces first instance, gsub will replace all => Global SUBstitution
		query = name.gsub(" ", "_")

		# GET request to Wikipedia
		uri = URI.parse("http://en.wikipedia.org/w/api.php?format=json&action=parse&page=#{query}")
		# http://en.wikipedia.org/w/index.php?action=render&title=James_Joyce
		response = Net::HTTP.get_response(uri)
		
		# Manipulate response
		data = response.body
		result = JSON.parse(data)

		# Write response to file separately as JSON and Ruby Hash
		# Not necessary, useful to visualise data structure
		File.open("response.json", 'w') { |file| file.write(result) }
		File.open("response.rb", 'w') { |file| file.write(result) }
		
		# get page HTML
		content = result["parse"]["text"]["*"]
		# get only summary
		content_array = content.split("</p>")
		summary = content_array[0].concat(content_array[1])
		# write summary to HTML file
		File.open("page.html", 'w') { |file| file.write(summary) }

		# regex = /<p>.*<\/p>/

		#puts content.match(regex)

		# puts content_array[0]
		# puts content_array[1]
		# puts content_array[2]
		# puts content_array[3]
		# return HTML file
		return summary

	end

end

# for testing module in command line
AuthorInfo.getInfo("William Shakespeare")