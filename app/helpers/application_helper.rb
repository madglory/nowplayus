module ApplicationHelper
  def npu_form_for(object, *args, &block)
    options = args.extract_options!
    simple_form_for(object, *(args << options.merge(:builder => NpuFormBuilder)), &block)
  end
end
