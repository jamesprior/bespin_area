module ActionView
  
  mattr_accessor :bespin_areas, :bespin_default_options
  ActionView::bespin_areas = false
  ActionView::bespin_default_options = {}
  
  module Helpers
    module FormHelper
      def text_area_with_bespin(object_name, method, options = {})
        BespinArea.fill_tag_options(options)
        text_area_without_bespin(object_name, method, options)
      end
      alias_method_chain :text_area, :bespin
    end
    
    module FormTagHelper
      def text_area_tag_with_bespin(name, content = nil, options = {})
        BespinArea.fill_tag_options(options)
        text_area_tag_without_bespin(name, content, options)
      end
      alias_method_chain :text_area_tag, :bespin
    end
    
    def bespin_area_includes_tag
      tag('link', {:id => 'bespin_base', :href => '/bespin_area'}) +
      javascript_include_tag('/bespin_area/BespinEmbedded.js') +
        stylesheet_link_tag('/bespin_area/BespinEmbedded.css')
    end
  end
end

module BespinArea
  extend self
  def fill_tag_options(options)
    bespin_options = options.delete(:bespin) # This could come in as true or false
    if bespin_options || ActionView::bespin_areas # check with sitewide defaults
      if options[:class].present?
        options[:class] += " bespin"
      else
        options[:class] = "bespin"
      end
      
      # if it came in as true and not as a set of options, use the defaults
      bespin_options = ActionView::bespin_default_options unless bespin_options.is_a? Hash
      if bespin_options.keys.present?
        options["data-bespinoptions".to_sym] = bespin_options.to_json
      end
    end
  end
end
