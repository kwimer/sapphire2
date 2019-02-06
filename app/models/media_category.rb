class MediaCategory < ApplicationRecord

  belongs_to :media, polymorphic: true
  belongs_to :category

  scope :in_category, -> (parent) { includes(:category).where(categories: {parent_id: parent.id}) }

end