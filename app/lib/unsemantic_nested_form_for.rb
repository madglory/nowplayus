class UnsemanticNestedFormFor < NestedForm::SimpleBuilder
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
end