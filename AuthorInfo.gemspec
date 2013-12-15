Gem::Specification.new do |s|
	s.name = 'AuthorInfo'
	s.version = '1.0.5'
	s.date = '2013-12-01'
	s.summary = "Get information about an author from Wikipedia"
	s.description = "Makes a GET request based on user input to Wikipedia API, parses response and manipulates the response data, then returns a summary of biographical information."
	s.authors = ['Niall Ryan']
	s.email = 'niall@niall-ryan.ie'
	s.homepage = "http://www.niall-ryan.ie"
  s.files = ["Rakefile", "lib/AuthorInfo.rb"]
  s.test_files = ["test/test_AuthorInfo.rb"]
  s.require_paths = ["lib"]
end