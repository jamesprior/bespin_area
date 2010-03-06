# Install hook code here

FileUtils.mkdir_p(File.join(RAILS_ROOT, 'public', 'javascripts', 'bespin_area'))
FileUtils.cp Dir[File.join(File.dirname(__FILE__), 'assets','javascripts','*.js')], File.join(RAILS_ROOT, 'public', 'javascripts', 'bespin_area')

FileUtils.mkdir_p(File.join(RAILS_ROOT, 'public', 'stylesheets', 'bespin_area'))
FileUtils.cp Dir[File.join(File.dirname(__FILE__), 'assets','stylesheets','*.css')], File.join(RAILS_ROOT, 'public', 'stylesheets', 'bespin_area')
