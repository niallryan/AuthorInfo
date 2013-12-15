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
    stripped_content_array = []
    content_array.each do |x|
      # Use Regex to strip out HTML tags => Update this to use Nokogiri or something similar to parse HTML instead
      y = x.gsub(%r{</?[^>]+?>}, '')
      # Add carriage returns to make text more readable
      y = y.gsub(". ", ".\n\n")
      # push mainpulated strings to new array
      stripped_content_array.push(y)
    end

    # concat first two paragraphs of response to create summary
		summary = stripped_content_array[0].concat(stripped_content_array[1])
		# write summary to text file
		File.open("page.txt", 'a') { |file| file.write(summary) }

    puts summary
		return summary

	end

end

# for testing module in command line
# AuthorInfo.getInfo("James Joyce")