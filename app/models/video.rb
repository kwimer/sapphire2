class Video < ApplicationRecord

  include ExternalFields

  belongs_to :media, polymorphic: true

end
