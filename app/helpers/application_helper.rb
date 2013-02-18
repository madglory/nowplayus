module ApplicationHelper
  def unsemantic_nested_form_for(*args, &block)
    options = args.extract_options!.reverse_merge(:builder => UnsemanticNestedFormFor)
    simple_form_for(*(args << options), &block) << after_nested_form_callbacks
  end

  def unsemantic_form_for(*args, &block)
    options = args.extract_options!.reverse_merge(:builder => UnsemanticFormFor)
    simple_form_for(*(args << options), &block)
  end
end
