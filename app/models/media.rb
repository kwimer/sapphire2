class Media < ApplicationRecord

  extend Mobility
  translates :title, :summary, :tagline
  include ExternalIds

  has_many :media_credits, as: :media
  has_many :credits, through: :media_credits
  has_many :images, as: :media
  has_many :videos, as: :media

end