class List < ApplicationRecord

  extend FriendlyId
  include UserStamp

  user_stamp
  friendly_id :name

  has_many :list_items, -> { order(:position) }, dependent: :destroy
  has_many :media, through: :list_items

end