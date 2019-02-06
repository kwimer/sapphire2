class Admin::CategoriesController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :show, :destroy ]
  belongs_to :category, instance_name: :parent_category, optional: true

  def parent
    @parent_category
  end

  protected

  def collection
    @categories ||= (parent? ? end_of_association_chain : end_of_association_chain.root).order(:slug)
  end

  private

  def category_params
    params.require(:category).permit(
        :name
    )
  end

end