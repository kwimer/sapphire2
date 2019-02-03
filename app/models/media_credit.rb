class MediaCredit < ApplicationRecord

  belongs_to :media, polymorphic: true
  belongs_to :credit

end