module ApplicationHelper

  def form_resource_path(parent = nil)
    resource.persisted? ? resource_path(resource) : collection_path(parent)
  end

end
