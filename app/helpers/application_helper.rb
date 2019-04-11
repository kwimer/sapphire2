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

  def nav_item(text, path, options = {})
    active_link_to text, path, {class: 'nav-link', wrap_tag: :li, wrap_class: 'nav-item'}.merge(options)
  end

  def icon_tag(icon, options = {})
    options[:class] = ["fa-#{icon}", options[:class]].compact
    content_tag(:i, '', options)
  end

  def avatar_tag(user, options = {})
    content_tag(:span, image_tag('defaults/user.jpg', alt: user.name), class: 'avatar')
  end

  def errors_for(object)
    if object.errors.any?
      message = "#{pluralize(object.errors.count, "error")} prohibited this #{object.class.model_name.human.downcase} from being saved"
      message = "Please fix the errors below"
      content_tag(:div, class: "alert alert-danger", role: "alert") do
        concat(content_tag(:h4, message, class: "alert-heading"))
        concat(content_tag(:ul) do
          object.errors.full_messages.each do |msg|
            concat content_tag(:li, msg)
          end
        end)
      end
    end
  end

end
