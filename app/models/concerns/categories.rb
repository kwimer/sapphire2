module Categories

  extend ActiveSupport::Concern

  included do
    has_many :media_categories, as: :media
    has_many :categories, through: :media_categories
  end

  def genres
    categories.where(parent: Category.root.find_by(name: "Genre"))
  end

  def genre_names
    genres.pluck(:name).join(', ')
  end

end
