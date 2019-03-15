module Selection

  extend ActiveSupport::Concern

  included do
    before_save :set_selection, if: :selection_changed?
  end

  def selection
    @selection.nil? ? selection_scope.exists? : @selection
  end

  def selection=(value)
    value = ActiveModel::Type::Boolean.new.cast(value)
    attribute_will_change!('selection') if selection != value
    @selection = value
  end

  def selection_changed?
    changed.include?('selection')
  end

  def set_selection
    selection ? selection_scope.first_or_create(year: Date.current.year, award_name: 'iGemSelection') : selection_scope.destroy_all
  end

  private

  def selection_scope
    Festival.where(name: 'iGems').first_or_create.awards.where(media: self)
  end

end