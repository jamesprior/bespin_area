# Install hook code here

js_dest = File.join(RAILS_ROOT, 'public', 'javascripts', 'bespin_area')
FileUtils.mkdir_p(js_dest, :verbose => true)
FileUtils.cp Dir[File.join(File.dirname(__FILE__), 'assets','javascripts','*.js')], js_dest, :verbose => true rescue nil

style_dest = File.join(RAILS_ROOT, 'public', 'stylesheets', 'bespin_area')
FileUtils.mkdir_p(style_dest, :verbose => true)
FileUtils.cp Dir[File.join(File.dirname(__FILE__), 'assets','stylesheets','*.css')], style_dest, :verbose => true rescue nil
FileUtils.cp_r File.join(File.dirname(__FILE__), 'assets','stylesheets','resources'), File.join(style_dest,'resources'), :verbose => true