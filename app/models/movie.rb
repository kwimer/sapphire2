class Movie < Media

  include Importer

  def name
    "#{title} (#{year})"
  end

  def year
    start_date.year
  end

end
