require 'rubygems/dependency_installer'

# SEE: http://en.wikibooks.org/wiki/Ruby_Programming/RubyGems#How_to_install_different_versions_of_gems_depending_on_which_version_of_ruby_the_installee_is_using

di = Gem::DependencyInstaller.new

begin
  if RUBY_VERSION >= '2.1'
    puts "Installing curses because Ruby #{RUBY_VERSION}"
    
    # BEWARE: repetition; SEE: sidekiq-spy.gemspec
    di.install "curses", "~> 1.0"
  else
    puts "Not installing curses because Ruby #{RUBY_VERSION}"
  end
rescue => e
  warn "#{$0}: #{e}"
  
  exit!
end

puts "Writing fake Rakefile"

# Write fake Rakefile for rake since Makefile isn't used
File.open(File.join(File.dirname(__FILE__), 'Rakefile'), 'w') do |f|
  f.write("task :default" + $/)
end
