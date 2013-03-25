module Decorators
  class Base
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper
    include ActionView::Helpers::TextHelper
    
    def initialize(subject)
      subject.public_methods.each do |method|
        (class << self; self; end).class_eval do
          define_method method do |*args|
            subject.send method, *args
          end
        end
      end
    end
  end
end