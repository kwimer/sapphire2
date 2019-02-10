class List < ApplicationRecord

  extend FriendlyId
  include UserStamp

  user_stamp
  friendly_id :name

  has_many :list_items, -> { order(:position) }

end
