module EOr
  
  def or_like_phrase(columns, value)
    columns = add_or_strings(columns)
    search =  build_search(columns, columns, ["%#{value}%" ])
  end
  
  def or_like_each_word(columns, value, delimiter=" ")
    if value.blank?
      search = or_like_phrase(columns, value)
    else
      words = add_wildcards(value.split(delimiter))
      all_columns = add_columns_for_each_word(columns, words)
      search = build_search(columns, all_columns, words)
    end
    search
  end
  
  private #-------------------------------------------------------------------
  
  def add_wildcards(words)
    words.each_with_index { |word, index| words[index] = "%#{word}%" }
  end
  
  def add_or_strings(columns)
    columns.each_with_index { |column, index| columns[index] = "lower(#{column}) like ?" }
  end
  
  def add_columns_for_each_word(columns, words)
    all_columns = []
    words.length.times { all_columns.concat(columns) }
    all_columns = all_columns.sort
    all_columns = add_or_strings(all_columns)
  end  
  
  def build_search(columns, columns_for_terms, words)
    search = ["(#{columns_for_terms.join(" or ")})"]
    columns.length.times { search.concat(words) }
    search
  end
  
end