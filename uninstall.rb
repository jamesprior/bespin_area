# Uninstall hook code here
FileUtils.remove_entry_secure File.join(RAILS_ROOT, 'public', 'javascripts', 'bespin_area')
FileUtils.remove_entry_secure File.join(RAILS_ROOT, 'public', 'stylesheets', 'bespin_area')
