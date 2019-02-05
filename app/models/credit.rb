class Credit < ApplicationRecord

  include ExternalFields

  belongs_to :media, polymorphic: true
  belongs_to :person

end
