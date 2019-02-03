class Person < ApplicationRecord

  include ExternalIds

  has_many :credits

end
