#encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)
require 'pgeon/version'

Gem::Specification.new do |s|
  s.name          = "pgeon"
  s.email         = "clemens@codeship.io"
  s.version       = Pgeon::VERSION
  s.date          = "2014-01-31"
  s.description   = "Pgeon will listen on your PostgreSQL tables and inform you about changes."
  s.summary       = "Ruby listener for PostgreSLQ notifies."
  s.authors       = ["Clemens Helm"]
  s.homepage      = "http://github.com/codeship/pgeon"
  s.license       = "MIT"

  files = []
  #files << "readme.md"
  #files << Dir["sql/**/*.sql"]
  files << Dir["{lib,test}/**/*.rb"]
  s.files = files
  s.test_files = s.files.select {|path| path =~ /^test\/.*_test.rb/}

  s.require_paths = %w[lib]

  s.add_dependency "pg", "~> 0.17.0"
  s.add_development_dependency "rspec"

  s.executables << "pgeon"
end
