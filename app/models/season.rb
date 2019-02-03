class Season < ApplicationRecord

  extend Mobility
  translates :title, :summary
  include ExternalIds

  belongs_to :series
  has_many :episodes, -> { order(:number) }, as: :parent
  has_many :media_credits, as: :media
  has_many :credits, through: :media_credits
  has_many :images, as: :media
  has_many :videos, as: :media

end
