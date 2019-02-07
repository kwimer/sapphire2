class Festival < ApplicationRecord

  extend FriendlyId
  friendly_id :name

  validates_presence_of :name

  has_many :awards
    accepts_nested_attributes_for :awards, reject_if: :all_blank, allow_destroy: true

end
