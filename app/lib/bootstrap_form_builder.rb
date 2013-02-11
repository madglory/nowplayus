module BootstrapFormBuilder
  delegate :content_tag, :tag, to: :@template

  def wrap_field(content)
    content_tag :div, class: 'input' do
      content
    end
  end

  def text_field(attribute, options = {})
    wrap_field(super)
  end

  def text_area(name, *args)
    wrap_field(super)
  end

  def password_field(name, *args)
    wrap_field(super)
  end

  def time_select(name, *args)
    wrap_field(super)
  end

  def date_picker (attribute, options = {})
    # add_class(options, "datepicker")
    text_field(attribute, options)
  end


  def rich_text_editor (attribute, options = {})
    text_area(attribute, options)
  end
end