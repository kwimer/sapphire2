class Credit < ApplicationRecord

  include ExternalIds

  belongs_to :media, polymorphic: true
  belongs_to :person

end
