class Person < ApplicationRecord

  include ExternalIds

  has_many :credits

  has_many :images, as: :media
  has_one :photo, -> { where(image_type: 'profiles', primary: true) },as: :media, class_name: 'Image'

end
