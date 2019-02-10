class Admin::ListItemsController < Admin::ApplicationController

  inherit_resources
  belongs_to :list
  actions :all, :except => [ :show, :destroy ]

  private

  def list_item_params
    params.require(:list_item).permit(
        :tmdb_import_id, :detail
    )
  end

end