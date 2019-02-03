class Series < Media

  has_many :seasons, -> { order(:number) }
  has_many :episodes, through: :seasons

end
