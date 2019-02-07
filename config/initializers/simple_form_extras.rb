# custom component requires input group wrapper
module InputGroup

  def prepend_simple
    options[:prepend_simple]
  end

  def prepend(wrapper_options = nil)
    span_tag = content_tag(:span, options[:prepend], class: "input-group-text")
    template.content_tag(:div, span_tag, class: "input-group-prepend")
  end

  def append(wrapper_options = nil)
    span_tag = content_tag(:span, options[:append], class: "input-group-text")
    template.content_tag(:div, span_tag, class: "input-group-append")
  end
end

# Register the component in Simple Form.
SimpleForm.include_component(InputGroup)

SimpleForm.setup do |config|

  # Add prepend/append
  config.wrappers :vertical_form, tag: 'div', class: 'form-group form-icons', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'form-control-label'
    b.wrapper :input_group_tag, tag: 'div', class: 'input-group' do |ba|
      ba.optional :prepend_simple
      ba.optional :prepend
      ba.use :input, class: 'form-control', error_class: 'is-invalid'#, valid_class: 'is-valid'
      ba.optional :append
    end
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # Flaoting labels (remark)
  config.wrappers :material, tag: 'div', class: 'form-group form-material floating', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :input, class: 'form-control', error_class: 'is-invalid'#, valid_class: 'is-valid'
    b.use :label, class: 'floating-label'
    b.use :error, wrap_with: { tag: 'small', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

end
