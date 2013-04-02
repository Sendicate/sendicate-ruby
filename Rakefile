# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "sendicate"
  gem.homepage = "http://github.com/evanwhalen/sendicate-ruby"
  gem.license = "MIT"
  gem.summary = %Q{Sendicate API Wrapper}
  gem.description = %Q{Use this Sendicate API wrapper to subscribe your users to your Sendicate mailing lists.}
  gem.email = "evanwhalendev@gmail.com"
  gem.authors = ["Evan Whalen"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new