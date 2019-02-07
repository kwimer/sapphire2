class Admin::CategoriesController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :show, :destroy ]
  belongs_to :category, instance_name: :parent_category, optional: true

  def parent
    @parent_category
  end

  def page_subtitle
    super || 'Settings'
  end

  def collection_title
    parent? ? parent.name.pluralize : 'Parent Categories'
  end

  protected

  def collection
    @categories ||= (parent? ? end_of_association_chain : end_of_association_chain.root).order('LOWER(name)')
  end

  private

  def category_params
    params.require(:category).permit(
        :name
    )
  end

end