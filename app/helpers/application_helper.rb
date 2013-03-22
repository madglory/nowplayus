module ApplicationHelper
  def markdown_format(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true)
    markdown.render(Sanitize.clean(text)).html_safe
  end

  def site_name
    content = "now"
    content << content_tag(:span, 'play', class: 'blue')
    content << "us"
    content.html_safe
  end

  def tooltip(text, tip, options = {})
    options[:class] = "#{options[:class]} has-tip"
    options[:data] ||= {}
    options[:data][:width] ||= '300px'
    options[:data].merge! tooltip: ''
    options.merge! title: tip
    content_tag :span, text, options
  end
end