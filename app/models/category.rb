class Category < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :scoped, scope: [:parent_id]

  alias_attribute  :category_parent_id,:parent_id

  belongs_to :parent, class_name: 'Category', optional: true
  has_many :categories, -> { order(:slug) }, foreign_key: :parent_id

  validates_uniqueness_of :name

  scope :root, -> { where(parent_id: nil) }

  def root?
    parent_id.nil?
  end

  def self.find_parent(id)
    Category.where(slug: id).first
  end

  def should_generate_new_friendly_id?
    name_changed? && !root?
  end

end
