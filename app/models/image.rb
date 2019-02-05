class Image < ApplicationRecord

  include ExternalIds

  belongs_to :media, polymorphic: true

end
