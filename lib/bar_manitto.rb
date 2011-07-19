require 'rubygems'
require 'dm-core'
gem 'dm-sqlite-adapter'
require 'dm-migrations'
gem 'twitter', "0.4.2"
require 'twitter'
require 'bar_manitto/crawler'
require 'bar_manitto/tweet'
require 'bar_manitto/helpers'

module BarManitto  
  class << self
    attr_accessor :config
  end
  
  def self.root
    File.expand_path(File.dirname(__FILE__) + '/..')
  end
  
  def self.init(config = nil)
    self.config = config.nil? ? YAML.load_file(File.join(Sinatra::Application.root, 'config', 'config.yml')) : config
    self.init_database
  end
  
  def self.init_database    
    init_database_connection
  end
  
  def self.init_database_connection
    DataMapper.setup(:default, self.config['database'])
    DataMapper.auto_upgrade!
  end  
end
