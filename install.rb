# Install hook code here

FileUtils.mkdir_p(File.join(RAILS_ROOT, 'public', 'bespin_area'), :verbose => true)
FileUtils.cp Dir[File.join(File.dirname(__FILE__), 'assets','*.*')], File.join(RAILS_ROOT, 'public', 'bespin_area'), :verbose => true

FileUtils.mkdir_p(File.join(RAILS_ROOT, 'public', 'bespin_area', 'resources'), :verbose => true)
FileUtils.cp_r Dir[File.join(File.dirname(__FILE__), 'assets', 'resources', '*')], File.join(RAILS_ROOT, 'public', 'bespin_area', 'resources'), :remove_destination => true, :verbose => true
