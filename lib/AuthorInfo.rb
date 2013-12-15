# https://github.com/augustl/net-http-cheat-sheet
# http://developer.yahoo.com/ruby/ruby-json.html
# http://www.mediawiki.org/wiki/API:Tutorial

require "net/http"
require "uri"
require "json"

module AuthorInfo

  # format user input => replace spaces with underscores
  # sub replaces first instance, gsub will replace all => Global SUBstitution
  def self.format_name(input)
    return input.gsub(" ", "_")
  end

  def self.make_request(input)
    # GET request to Wikipedia
    uri = URI.parse("http://en.wikipedia.org/w/api.php?format=json&action=parse&page=#{input}")
    # make request
    response = Net::HTTP.get_response(uri)
    return response
  end

  def self.convert_response(input)
    # Manipulate response
    data = input.body
    # convert JSON to Ruby Hash
    result = JSON.parse(data)
    return result
  end

  def self.write_response(input)
    # Write response to file as Ruby Hash
    # Not necessary, useful to visualise data structure
    File.open("response.rb", 'w') { |file| file.write(input) }
  end

  def self.get_page(input)
    # get page HTML
    content = input["parse"]["text"]["*"]
    return content
  end

  def self.get_summary(input)
    # get only summary
    content_array = input.split("</p>")
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

    return summary

  end

  def self.getInfo(name)

    query = format_name(name)

    response = make_request(query)

    result = convert_response(response)

    write_response(result)

    content = get_page(result)

    summary = get_summary(content)

    puts summary
    return summary

  end

end

# for testing module in command line
# AuthorInfo.getInfo("James Joyce")