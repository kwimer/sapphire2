class Media < ApplicationRecord

  extend Mobility
  translates :title, :summary, :tagline
  include ExternalIds

  has_many :media_credits, as: :media
  has_many :credits, through: :media_credits
  has_many :images, as: :media
  has_many :videos, as: :media

  has_one :backdrop, -> { where(image_type: 'backdrops', primary: true) }, class_name: 'Image'
  has_one :poster, -> { where(image_type: 'posters', primary: true) }, class_name: 'Image'
  has_one :still, -> { where(image_type: 'stills', primary: true) }, class_name: 'Image'

end