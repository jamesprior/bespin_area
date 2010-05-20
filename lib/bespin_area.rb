module ActionView
  
  mattr_accessor :bespin_areas, :bespin_default_options
  ActionView::bespin_areas = false
  ActionView::bespin_default_options = {}
  
  module Helpers
    module FormHelper
      def text_area_with_bespin(object_name, method, options = {})
        bespin_options = options.delete(:bespin)
        bespin_options = ActionView::bespin_areas if bespin_options.nil?
        field_name = "#{object_name}_#{method}"
        tag  = ''
        if bespin_options 
          helpful_accessor = InstanceTag.new(object_name, method, self)
          tag += include_bespin_for(field_name, helpful_accessor.value(helpful_accessor.object), bespin_options)
        end
        tag + text_area_without_bespin(object_name, method, options)
      end
      alias_method_chain :text_area, :bespin
    end
    
    module FormTagHelper
      def text_area_tag_with_bespin(name, content = nil, options = {})
        bespin_options = options.delete(:bespin)
        bespin_options = ActionView::bespin_areas if bespin_options.nil?
        ( bespin_options ? include_bespin_for(name, content, bespin_options) : '' ) +
          text_area_tag_without_bespin(name, content, options)
      end
      alias_method_chain :text_area_tag, :bespin
    end
    
    def bespin_area_includes_tag
      javascript_include_tag('bespin_area/BespinEmbedded.compressed.js', 'bespin_area/bespin_area') +
        stylesheet_link_tag('bespin_area/BespinEmbedded.css')
    end
    
    def include_bespin_for(field_name, content, bespin_options = {})
      bespin_options = ActionView::bespin_default_options if bespin_options.empty?
      content_tag(:div, nil, {:id => "#{field_name}_editor", :style => "visibility:hidden; margin: 0; padding: 0; border: 0; height: 0px; width:0px; "}) +
      javascript_tag( 
        %{
          SC.ready(function() {            	
            	#{RAILS_ENV == 'development' ? "window.bespinArea = " : ""}
            	BespinArea.create(#{{:textAreaInputId => field_name, :bespinOptions => bespin_options, :initialContent => content}.to_json});
          });
        }
      )
    end
  end
end
