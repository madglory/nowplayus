
module ApplicationHelper

  def markdown_format(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true)
    markdown.render(text).html_safe
  end

  def unsemantic_nested_form_for(*args, &block)
    options = args.extract_options!.reverse_merge(:builder => UnsemanticNestedFormFor)
    simple_form_for(*(args << options), &block) << after_nested_form_callbacks
  end

  def unsemantic_form_for(*args, &block)
    options = args.extract_options!.reverse_merge(:builder => UnsemanticFormFor)
    simple_form_for(*(args << options), &block)
  end
end
