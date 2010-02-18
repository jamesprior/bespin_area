module ActionView
  
  mattr_accessor :bespin_areas
  ActionView::bespin_areas = false
  
  module Helpers
    module FormHelper
      def text_area_with_bespin(object_name, method, options)
        bespin = options.delete(:bespin)
        bespin = ActionView::bespin_areas if bespin.nil?
        ( bespin ? include_bespin_for(object_name, method) : '' ) +
          text_area_without_bespin(object_name, method, options) 
      end
      alias_method_chain :text_area, :bespin

      def include_bespin_for(object_name, method)
        field_name = "#{object_name}_#{method}"
        content = self.instance_variable_get("@#{object_name.to_s}").send(method)
        script_tags(bespin_content(object_name, method)) + "<div id='#{field_name}_editor' style=' margin: 0; padding: 0; border: 0; height: 300px; ' class='bespin'>#{content}</div>"
      end
      
      private
      
      def bespin_content(object_name, method)
        field_name = "#{object_name}_#{method}"
        %{
          window.onBespinLoad = function() {
            var editingDiv = document.getElementById("#{field_name}_editor");

            var bespin = editingDiv.bespin;

          	var listener = SC.Object.create({
          	  textAreaInput: document.getElementById('#{field_name}'),
          	  textStorageEdited: function(sender, oldRange, newRange) {
          	      this.textAreaInput.value = sender.value();
          	  }
          	});

          	editingDiv.style.display="";
          	listener.textAreaInput.style.display="none"

          	listener.textAreaInput.value = bespin.getContent();

          	bespin.getPath("editorPane.editorView.layoutManager.textStorage").addDelegate(listener);
        	}
        }
      end
            
      def script_tags(js_code = '')
         ( js_code.blank? ? '' : "<script>#{js_code}</script>" )
      end
    end
  end
end
