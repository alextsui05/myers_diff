$LOAD_PATH << File.expand_path('lib', __dir__)
require 'myers_diff/version'

Gem::Specification.new do |s|
  s.name = 'myers_diff'
  s.version = MyersDiff::VERSION
  s.date = '2020-05-27'
  s.summary = 'Implementation of Myers 1986 text diff algorithm'
  s.description = 'Implementation of Myers 1986 text diff algorithm '\
                  'that started as a port of the jsdiff project with '\
                  'plans to branch out to human-friendly diffs'
  s.authors = ['Alex Tsui']
  s.email = 'alextsui@pm.me'
  s.files = Dir.glob('lib/**/*')
  s.homepage = 'https://github.com/alextsui05/myers_diff'
  s.license = 'MIT'
end
