module ApplicationHelper
  def markdown_format(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true)
    markdown.render(Sanitize.clean(text)).html_safe
  end
end