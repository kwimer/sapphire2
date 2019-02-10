class Admin::ListsController < Admin::ApplicationController

  inherit_resources
  actions :all, :except => [ :show ]

  private

  def list_params
    params.require(:list).permit(
        :name, :description
    )
  end

end