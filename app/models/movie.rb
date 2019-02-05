class Movie < Media

  include Importer
  friendly_id :title_and_year

  def title_and_year
    "#{title} (#{year})"
  end

  def year
    start_date.year
  end

end
