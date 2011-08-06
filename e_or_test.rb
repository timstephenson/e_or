#require "e_or"
require File.expand_path("../e_or", __FILE__)
require "test/unit"

class Object
  # This is intended for use in rails. 
  # Extening object in this case to get the blank? method.
  def blank?
     respond_to?(:empty?) ? empty? : !self
  end
end

class TestEOr < Test::Unit::TestCase
  def setup
      @object = Object.new
      @object.extend(EOr)
  end
  
  def test_or_like_phrase_with_one_column
    result = ["(lower(column_1) like ?)", "%fred flintstone%"]
    assert_equal(result, @object.or_like_phrase(["column_1"], "fred flintstone"))
  end
  
  def test_or_like_phrase_with_three_columns
    result = ["(lower(column_1) like ? or lower(column_2) like ? or lower(column_3) like ?)", "%fred flintstone%", "%fred flintstone%", "%fred flintstone%"]
    assert_equal(result, @object.or_like_phrase(["column_1", "column_2", "column_3"], "fred flintstone"))
  end
  
  def test_or_like_each_word_with_one_column
    result = ["(lower(column_1) like ? or lower(column_1) like ?)", "%fred%", "%flintstone%"]
    assert_equal(result, @object.or_like_each_word(["column_1"], "fred flintstone"))
  end
  
  def test_or_like_each_word_with_three_columns
    result = ["(lower(column_1) like ? or lower(column_1) like ? or lower(column_2) like ? or lower(column_2) like ? or lower(column_3) like ? or lower(column_3) like ?)",
     "%fred%",
     "%flintstone%",
     "%fred%",
     "%flintstone%",
     "%fred%",
     "%flintstone%"]
    assert_equal(result, @object.or_like_each_word(["column_1", "column_2", "column_3"], "fred flintstone"))
  end
  
  def test_or_like_each_word_with_three_columns_custom_delimeiter
    result = ["(lower(column_1) like ? or lower(column_1) like ? or lower(column_2) like ? or lower(column_2) like ? or lower(column_3) like ? or lower(column_3) like ?)",
     "%fred flintstone%",
     "%barny rubble%",
     "%fred flintstone%",
     "%barny rubble%",
     "%fred flintstone%",
     "%barny rubble%"]
    assert_equal(result, @object.or_like_each_word(["column_1", "column_2", "column_3"], "fred flintstone, barny rubble", ", "))
  end
  
end