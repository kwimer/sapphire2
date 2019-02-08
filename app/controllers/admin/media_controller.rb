class Admin::MediaController < Admin::ApplicationController

  def import
    media = Media.import(params[:tmbd_import_id])
    redirect_to send("edit_admin_#{media.type.downcase}_path", media)
  end

end