module ApplicationHelper

  def form_resource_path(parent = nil)
    resource.persisted? ? resource_path(resource) : collection_path(parent)
  end

  def flash_tag
    if flash[:notice] || flash[:alert]
      content_tag(:div, flash[:notice] || flash[:alert], class: "alert alert-#{flash[:notice] ? 'success' : 'danger'} alert-dismissible fade show m-0", role: "alert")
    end
  end

  def menu_item(text, path, icon)
    content = icon_tag(icon) + content_tag(:span, text)
    active_link_to content, path, class: 'nav-link', wrap_tag: :li, wrap_class: 'nav-item'
  end

  def icon_tag(icon, options = {})
    options[:class] = ['material-icons', options[:class]].compact
    content_tag(:i, icon, options)
  end

end
