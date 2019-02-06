class Festival < ApplicationRecord

  extend FriendlyId
  friendly_id :name

  has_many :awards
    accepts_nested_attributes_for :awards, reject_if: :all_blank, allow_destroy: true

end
