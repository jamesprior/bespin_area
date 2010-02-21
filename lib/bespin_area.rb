module ActionView
  
  mattr_accessor :bespin_areas
  ActionView::bespin_areas = true
  
  module Helpers
    module FormHelper
      def text_area_with_bespin(object_name, method, options = {})
        bespin_options = options.delete(:bespin)
        bespin_options = ActionView::bespin_areas if bespin_options.nil?
        field_name = "#{object_name}_#{method}"
        ( bespin_options ? include_bespin_for(field_name, bespin_options) : '' ) +
          text_area_without_bespin(object_name, method, options)
      end
      alias_method_chain :text_area, :bespin
    end
    
    module FormTagHelper
      def text_area_tag_with_bespin(name, content = nil, options = {})
        bespin_options = options.delete(:bespin)
        bespin_options = ActionView::bespin_areas if bespin_options.nil?
        ( bespin_options ? include_bespin_for(name, bespin_options) : '' ) +
          text_area_tag_without_bespin(name, content, options)
      end
      alias_method_chain :text_area_tag, :bespin
    end
    
    def include_bespin_for(field_name, bespin_options = {})
      bespin_options ||= ActionView::bespin_default_options if bespin_options.empty?
      bespin_options[:textAreaInputId] = field_name
      content_tag(:div, nil, {:id => "#{field_name}_editor", :style => "visibility:hidden; margin: 0; padding: 0; border: 0; height: 0px; width:0px; "}) +
      javascript_tag( 
        %{
          SC.ready(function() {            	
            	#{RAILS_ENV == 'development' ? "window.bespin_area = " : ""}
            	BespinArea.create(#{bespin_options.to_json});
          });
        }
      )
    end
  end
end
