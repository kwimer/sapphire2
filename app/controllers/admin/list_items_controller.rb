class Admin::ListItemsController < Admin::ApplicationController

  inherit_resources
  belongs_to :list
  actions :all, :except => [ :show ]

  private

  def list_item_params
    params.require(:list_item).permit(
        :position, :tmdb_import_id, :detail
    )
  end

end