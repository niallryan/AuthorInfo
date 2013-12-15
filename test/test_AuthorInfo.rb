require 'test/unit'
require 'AuthorInfo'

class AuthorInfoTest < Test::Unit::TestCase

  # Test if query has a space in it
  def test_query_has_no_spaces
    t = AuthorInfo.format_name("James Joyce")
    assert_equal(true, !t.include?(" "))
  end

  # Test if request works, response has data
  def test_api_request
    t = AuthorInfo.make_request("James_Joyce")
    assert_equal(true, t.length > 0)
  end

  # Figure out how to test file creation

    # Test that response files are created
    # def test_response_file_creation
    #    AuthorInfo.write_response(test)
    #    assert_equal(true, File.exist?("response.rb"))
    #    assert_equal(true, File.exist?("response.json"))
    # end

    # Test that summary file is created
    # def test_summary_file_creation
    #   t = AuthorInfo.getInfo("James Joyce")
    #   assert_equal(true, File.exist?("page.txt"))
    # end

  # Test get_page returns correct content
  def test_get_page_content
    t = AuthorInfo.get_page({"parse" => {"text" => {"*" => "some content"}}})
    assert_equal(true, t === "some content")
  end

  def test_getInfo_returns_something
    t = AuthorInfo.getInfo("James Joyce")
    assert_equal(true, t.length > 0)
  end


end