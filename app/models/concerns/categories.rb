module Categories

  extend ActiveSupport::Concern

  included do
    has_many :media_categories, as: :media
    has_many :categories, through: :media_categories
  end

end
