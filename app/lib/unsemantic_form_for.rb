class UnsemanticFormFor < SimpleForm::FormBuilder
  delegate :content_tag, :tag, to: :@template
  
  def wrap_input(content)
    content_tag :fieldset do
      content
    end
  end

  def input(attribute_name, *args, &block)
    wrap_input super
  end

  def collection_select(attribute, choices, value_method, text_method, options = {}, html_options = {}, *args, &block)
    wrap_input super
  end

  def time_zone_select(object, method, priority_zones = nil, options = {}, html_options = {})
    wrap_input super
  end
end