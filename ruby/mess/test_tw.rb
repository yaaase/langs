require 'test/unit'
require '/home/mbillie/langs/ruby/mess/tw_word_cloud'
require '/home/mbillie/langs/ruby/mess/loader'

class Tester < Test::Unit::TestCase

  def test_we_catch_the_exception
    parser = WordParser.new
    data = nil
    assert_equal(0, parser.parse(data))
  end

  def test_we_can_parse_json
    js_parser = JsonParser.new
    data = js_parser.open("/home/mbillie/langs/ruby/mess/pretty_hash.json")
    parser = WordParser.new
    assert_equal("1650", parser.parse(data))
  end

  def test_search_terms_words
    st = SearchTerms.new
    assert(st.terms.size > 0)
  end

end
