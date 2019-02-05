class Episode < Media

  friendly_id :season_number_and_title

  belongs_to :parent, polymorphic: true

  def season_number_and_title
    "S#{'%02i' % parent.number}E#{'%02i' % number} #{title}"
  end

end
