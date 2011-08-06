# EOr is a simple module for generating where clauses for multiple columns with ors between them.

This is intended for very simple use cases where Sphinx may be overkill.

Usage
```ruby
class Project < ActiveRecord::Base
  extend EOr
```

Then use it like this: 
```ruby
def some_finder(value)
  where(or_like_phrase(["column_1", "column_2", "column_3"], value)
end

# Generates: ["(lower(column_1) like ? or lower(column_2) like ? or lower(column_3) like ?)", "%fred flintstone%", "%fred flintstone%", "%fred flintstone%"]

def some_finder(value)
  where(or_like_each_word(["column_1"], value)
end

# Generates: ["(lower(column_1) like ? or lower(column_1) like ?)", "%fred%", "%flintstone%"]
```
