class Series < Media

  include Importer
  friendly_id :title

  has_many :seasons, -> { order(:number) }
  has_many :episodes, through: :seasons

end
