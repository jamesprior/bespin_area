# Install hook code here

FileUtils.mkdir_p(File.join(RAILS_ROOT, 'public', 'bespin_area'))
FileUtils.cp Dir[File.join(File.dirname(__FILE__), 'assets','*.*')], File.join(RAILS_ROOT, 'public', 'bespin_area')

FileUtils.mkdir_p(File.join(RAILS_ROOT, 'public', 'bespin_area', 'resources'))
FileUtils.cp_r Dir[File.join(File.dirname(__FILE__), 'assets', 'resources', '*')], File.join(RAILS_ROOT, 'public', 'bespin_area', 'resources'), :remove_destination => true
