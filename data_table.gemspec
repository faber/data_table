lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'data_table/version'

Gem::Specification.new do |s|
  s.name        = "data_table"
  s.version     = DataTable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Faber"]
  s.email       = ["dafaber@gmail.com"]
  s.homepage    = "http://github.com/faber/data_table"
  s.summary     = "Makin tables from data"


  s.add_dependency('activerecord', '>= 3.1')
  s.add_dependency('tilt', '>= 1.3')

  s.files        = Dir.glob("lib/**/*") + %w(README.markdown)
  s.require_path = 'lib'
end