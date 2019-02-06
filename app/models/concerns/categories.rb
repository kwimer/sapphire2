module Categories

  extend ActiveSupport::Concern

  included do
    has_many :media_categories, as: :media
      #accepts_nested_attributes_for :media_categories, reject_if: :all_blank, allow_destroy: true
    has_many :categories, through: :media_categories
  end

end
