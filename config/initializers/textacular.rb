module Textacular

  def self.searchable_language
    'simple'
  end

  def self.to_query(q)
    %('#{q.to_s.gsub(/'/, "''")}':*)
  end

  # Fix rank

  def assemble_query(similarities, conditions, exclusive)
    rank = connection.quote_column_name('rank')

    select("#{quoted_table_name + '.*,' if select_values.empty?} #{similarities.join(" + ")} AS #{rank}").
      where(conditions.join(exclusive ? " AND " : " OR "))
  end

  # Fix for special chars
  # https://github.com/Sportech/textacular/commit/13d59e1d77c5d7cf158d77534054039bf94e0268

  # def basic_similarity_string(table_name, column, search_term)
  #   "COALESCE(ts_rank(to_tsvector(#{quoted_language(column)}, #{table_name}.#{column}::text), plainto_tsquery(#{quoted_language(column)}, #{search_term}::text)), 0)"
  # end
  #
  # def basic_condition_string(table_name, column, search_term)
  #   "to_tsvector(#{quoted_language(column)}, #{table_name}.#{column}::text) @@ plainto_tsquery(#{quoted_language(column)}, #{search_term}::text)"
  # end
  #
  # def advanced_similarity_string(table_name, column, search_term)
  #   "COALESCE(ts_rank(to_tsvector(#{quoted_language(column)}, #{table_name}.#{column}::text), to_tsquery(#{quoted_language(column)}, #{connection.quote(search_term)}::text)), 0)"
  # end
  #
  # def advanced_condition_string(table_name, column, search_term)
  #   "to_tsvector(#{quoted_language(column)}, #{table_name}.#{column}::text) @@ to_tsquery(#{quoted_language(column)}, #{connection.quote(search_term)}::text)"
  # end
  #
  # def quoted_language(column = nil)
  #   (@quoted_languages ||= {})[column] ||= connection.quote(searchable_language(column))
  # end

  def searchable_language(search_term = nil)
    Textacular.searchable_language
  end

end