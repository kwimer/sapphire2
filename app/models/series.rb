class Series < Media

  friendly_id :title

  has_many :seasons, -> { order(:number) }
  has_many :episodes, through: :seasons

end
