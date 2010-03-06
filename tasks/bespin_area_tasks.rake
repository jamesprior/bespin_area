namespace :bespin_area do

  desc 'Installs required javascript and stylesheet files to the public/ directory.'
  task :install do
    require File.join(File.dirname(__FILE__), '..', 'install')
  end

  desc 'Removes the javascript and stylesheet for the plugin.'
  task :remove do
    require File.join(File.dirname(__FILE__), '..', 'uninstall')
  end

end