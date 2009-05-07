$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'bar_manitto'

require 'rubygems'
require 'twitter'

task :default do
  Dir["test/**/*.rb"].sort.each { |test|  load test }
end

namespace :bar do
  namespace :manitto do
    desc 'Search for #barmanitto'
    task :crawl do
      BarManitto::Crawler.new('#barmanitto').crawl   
    end
  end
end